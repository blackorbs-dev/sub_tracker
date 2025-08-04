part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  const factory DashboardState.initial() = Initial;
  const factory DashboardState.loaded({
    required String userName,
    double walletBalance,
    CurrentSubscription currentSubscription,
    SubscriptionOverview subscriptionOverview
  }) = Loaded;
}

final class Initial extends DashboardState {
  const Initial();
  @override
  List<Object> get props => [];
}

final class Loaded extends DashboardState {
  const Loaded({
    required this.userName,
    this.walletBalance,
    this.currentSubscription,
    this.subscriptionOverview
  });

  final String userName;
  final double? walletBalance;
  final CurrentSubscription? currentSubscription;
  final SubscriptionOverview? subscriptionOverview;

  Loaded copyWith({
    String? userName,
    double? walletBalance,
    Object? currentSubscription = noUpdate,
    SubscriptionOverview? subscriptionOverview
  }){
    return Loaded(
      userName: userName ?? this.userName,
      walletBalance: walletBalance ?? this.walletBalance,
      currentSubscription: currentSubscription == noUpdate ? this.currentSubscription : currentSubscription as CurrentSubscription?,
      subscriptionOverview: subscriptionOverview ?? this.subscriptionOverview
    );
  }

  @override
  List<Object?> get props => [userName, walletBalance, currentSubscription, subscriptionOverview];
}
