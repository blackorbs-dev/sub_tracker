import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/features/dashboard/domain/subscription_mapper.dart';

import '../../../../core/util/constants.dart';
import '../../../shared/domain/account_repository.dart';
import '../../../subscription/domain/repository/subscription_repository.dart';
import '../../../wallet/domain/repository/wallet_repository.dart';
import '../../domain/current_subscription.dart';
import '../../domain/subscription_overview.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  StreamSubscription? walletSub;
  StreamSubscription? currentSubscriptionSub;
  StreamSubscription? subscriptionListSub;

  final AccountRepository _accountRepository;
  final WalletRepository _walletRepository;
  final SubscriptionRepository _subscriptionRepository;

  DashboardCubit(this._accountRepository, this._walletRepository, this._subscriptionRepository)
      : super(DashboardState.initial()){
    _init();
  }

  void _init() async{
    final userName = await _accountRepository.getUserName();
    emit(DashboardState.loaded(userName: userName??'User'));

    walletSub = (await _walletRepository.getWalletStream()).listen((wallet) {
      emit((state as Loaded).copyWith(walletBalance: wallet.balance));
    });

    currentSubscriptionSub = (await _subscriptionRepository.getCurrentSubscription()).listen((subscription) {
      emit((state as Loaded).copyWith(currentSubscription: subscription?.asCurrent));
    });

    subscriptionListSub = (await _subscriptionRepository.getAllSubscription()).listen((subscriptions) {
      emit((state as Loaded).copyWith(subscriptionOverview: subscriptions.toOverview()));
    });
  }

  @override
  Future<void> close() {
    walletSub?.cancel();
    currentSubscriptionSub?.cancel();
    subscriptionListSub?.cancel();
    return super.close();
  }

}
