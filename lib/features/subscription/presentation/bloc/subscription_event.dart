part of 'subscription_bloc.dart';

sealed class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
}

final class Initialize extends SubscriptionEvent{
  @override
  List<Object?> get props => [];
}

final class Subscribe extends SubscriptionEvent{
  final SubscriptionPlan subPlan;
  const Subscribe(this.subPlan);

  @override
  List<Object?> get props => [subPlan];
}

final class BillingTypeChanged extends SubscriptionEvent{
  final BillingType billingType;
  const BillingTypeChanged(this.billingType);

  @override
  List<Object?> get props => [billingType];

}

final class CancelSubscription extends SubscriptionEvent{
  @override
  List<Object?> get props => [];
}

final class ClearMessage extends SubscriptionEvent{
  @override
  List<Object?> get props => [];
}
