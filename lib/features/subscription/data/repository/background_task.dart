import 'package:flutter/cupertino.dart';
import 'package:sub_tracker/core/error/extensions.dart';
import 'package:sub_tracker/core/util/response.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../core/service/notification_service.dart';
import '../../../../core/storage/secure_storage_impl.dart';
import '../../../../core/util/constants.dart';
import '../../../shared/data/app_database.dart';
import '../../domain/models/auto_renew_status.dart';
import 'subscription_repository_impl.dart';

void initBackgroundWorker() async{
  await Workmanager().initialize(callbackDispatcher);
  WidgetsBinding.instance.addPostFrameCallback((_) => runBackgroundTask());
}

void runBackgroundTask() async{
  await NotificationService().requestNotificationPermission();
  Workmanager().registerOneOffTask(
    AppConstant.oneOffTaskId,
    AppConstant.oneOffTaskId
  );
  Workmanager().registerPeriodicTask(
    AppConstant.periodicTaskId,
    AppConstant.periodicTaskId,
    frequency: const Duration(days: 1)
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async{
    final notificationService = NotificationService();

    final database = await AppDatabase.create();
    final subscriptionRepository = SubscriptionRepositoryImpl(
      subscriptionDao: database.subscriptionDao(),
      walletDao: database.walletDao(),
      secureStorage: SecureStorageImpl()
    );

    // Try renew current subscription
    final response = await subscriptionRepository.renewCurrentSubscription();
    response.onSuccess((status) {
      switch(status){
        case AutoRenewStatus.noActionRequired: break;
        case AutoRenewStatus.pending: notificationService.showNotification(
            'Your subscription will soon expire. Kindly ensure sufficient balance for auto renewal'
        );
        case AutoRenewStatus.success: notificationService.showNotification(
          'Your subscription has been renewed successfully'
        );
      }
    }).onError((error) {
      notificationService.showNotification(
          'Subscription renewal failed with message: ${error.message()}'
      );
    });

    database.close();

    return true;
  });
}