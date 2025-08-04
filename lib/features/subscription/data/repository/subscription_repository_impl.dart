import 'package:sub_tracker/core/storage/extension.dart';
import '../../../../core/error/error.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/util/location.dart';
import '../../../../core/util/response.dart';
import '../../../../core/util/safe_caller.dart';
import '../../../wallet/data/dao/wallet_dao.dart';
import '../../../wallet/domain/models/transaction_status.dart';
import '../../domain/models/auto_renew_status.dart';
import '../../domain/models/billing_method.dart';
import '../../domain/models/billing_type.dart';
import '../../domain/models/subscription.dart';
import '../../domain/models/subscription_plan.dart';
import '../../domain/repository/subscription_repository.dart';
import '../dao/subscription_dao.dart';
import '../entity/subscription_entity.dart';
import '../mapper/subscription_mapper.dart';
import 'background_task.dart';

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final SubscriptionDao _subscriptionDao;
  final WalletDao _walletDao;
  final SecureStorage _secureStorage;

  SubscriptionRepositoryImpl({
    required SubscriptionDao subscriptionDao,
    required WalletDao walletDao,
    required SecureStorage secureStorage
  }): _subscriptionDao = subscriptionDao,
        _walletDao = walletDao,
        _secureStorage = secureStorage;

  @override
  Future<Stream<List<Subscription>>> getAllSubscription() async {
    final response = await safeCall(() async {
      final userId = await _secureStorage.userId;
      return _subscriptionDao.watchAllSubscriptions(userId);
    });
    return switch(response){
      SuccessResponse(data: final subscriptionStream) =>
          subscriptionStream.map((list) =>
              list.map((item) => item.toModel()).toList()
          ),
      ErrorResponse(:final error) => Stream.error(error)
    };
  }

  @override
  Future<Stream<Subscription?>> getCurrentSubscription() async {
    final response = await safeCall(() async {
      final userId = await _secureStorage.userId;
      return _subscriptionDao.watchCurrentSubscription(userId);
    });
    return switch(response){
      SuccessResponse(data:final stream) =>
          stream.map((item) => item?.toModel()),
      ErrorResponse(:final error) => Stream.error(error)
    };
  }

  @override
  Future<Response<void, DataError>> subscribe(
      SubscriptionPlan plan, BillingType billingType, BillingMethod billingMethod
  ) => safeCall(() async {
    final userId = await _secureStorage.userId;
    final currentSub = _subscriptionDao.getCurrentSubscription(userId);
    final newStartDate = currentSub?.isExpired == false
        ? currentSub!.endDate : DateTime.now(); // Renew existing subscription if it's not expired
    await _createSubscription(plan, billingType, billingMethod, newStartDate, userId);
    if (currentSub != null) {
      currentSub.isActive = false;
      _subscriptionDao.insert(currentSub);
    }
  });

  @override
  Future<Response<AutoRenewStatus, DataError>> renewCurrentSubscription() async{
    final userIdResponse = await safeCall(() => _secureStorage.userId);
    if(userIdResponse is ErrorResponse){
      return SuccessResponse(AutoRenewStatus.noActionRequired);
    }
    final userId = (userIdResponse as SuccessResponse).data;
    final currentSub = _subscriptionDao.getCurrentSubscription(userId);
    if (currentSub == null) {
      return SuccessResponse(AutoRenewStatus.noActionRequired);
    }
    if(currentSub.isExpired){
      final response = await safeCall(() =>
         _createSubscription(
            currentSub.plan!,
            currentSub.billingType!,
            BillingMethod.autoRenewed,
            DateTime.now(),
            userId
        )
      );
      switch(response){
        case SuccessResponse():
          currentSub.isActive = false;
          _subscriptionDao.insert(currentSub);
          return SuccessResponse(AutoRenewStatus.success);
        case ErrorResponse(:final error): return ErrorResponse(error);
      }
    }
    if(currentSub.isPendingAutoRenew){
      return SuccessResponse(AutoRenewStatus.pending);
    }
    return SuccessResponse(AutoRenewStatus.noActionRequired);
  }

  Future<void> _createSubscription(
      SubscriptionPlan plan,
      BillingType billingType,
      BillingMethod billingMethod,
      DateTime startDate,
      int userId
  ) async{
    _deductFromWallet(plan, billingType, userId);
    final location = await getCurrentLocation();

    final newSub = SubscriptionEntity(
      isActive: true,
      startDate: DateTime.now(),
      endDate: getExpirationDate(billingType, startDate),
    )..plan = plan
      ..billingType = billingType
      ..billingMethod = billingMethod
      ..location.target = location
      ..user.targetId = userId;

    _subscriptionDao.insert(newSub);
  }

  @override
  Future<Response<void, DataError>> cancelSubscription() =>
      safeCall(() async {
        await Future.delayed(Duration(seconds: 2)); // simulate network request
        final userId = await _secureStorage.userId;
        final currentSub = _subscriptionDao.getCurrentSubscription(userId);
        if (currentSub != null) {
          currentSub.isActive = false;
          _subscriptionDao.insert(currentSub);
        }
      });

  @override
  Future<Response<void, DataError>> adjustCurrentSubStartDate() =>
      safeCall(() async {
        final userId = await _secureStorage.userId;
        final currentSub = _subscriptionDao.getCurrentSubscription(userId);
        if (currentSub != null) {
          currentSub.startDate = currentSub.startDate.subtract(Duration(days: 1));
          currentSub.endDate = currentSub.endDate.subtract(Duration(days: 1));
          _subscriptionDao.insert(currentSub);
          if(currentSub.isPendingAutoRenew){
            runBackgroundTask(); // try auto renew from background service
          }
        }
      });

  void _deductFromWallet(SubscriptionPlan plan, BillingType type, int userId) {
    final transactionStatus = _walletDao.debit(
        userId, getSubAmount(plan, type),
        '${plan.name} Plan - ${type.name}'
    );
    if (transactionStatus == TransactionStatus.failed) {
      throw CustomException('Insufficient balance');
    }
  }

  DateTime getExpirationDate(BillingType billingType, DateTime startDate){
    return switch (billingType) {
      BillingType.monthly =>
          DateTime(startDate.year, startDate.month + 1, startDate.day),
      BillingType.quarterly =>
          DateTime(startDate.year, startDate.month + 3, startDate.day)
    };
  }
}

double getSubAmount(SubscriptionPlan plan, BillingType type){
  return plan.price * (type == BillingType.monthly ? 1 : (3*(100-SubscriptionRepository.discount)/100));
}