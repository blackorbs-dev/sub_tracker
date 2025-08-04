part of 'subscription_bloc.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.currentSub,
    this.selectedPlan,
    this.selectedBillingType = BillingType.monthly,
    this.message,
    this.isLoading = false
  });

  final Subscription? currentSub;
  final SubscriptionPlan? selectedPlan;
  final BillingType selectedBillingType;
  final String? message;
  final bool isLoading;

  SubscriptionState copyWith({
    Object? currentSub = noUpdate,
    SubscriptionPlan? selectedPlan,
    BillingType? selectedBillingType,
    Object? message = noUpdate,
    bool? isLoading
  }) => SubscriptionState(
      currentSub: currentSub == noUpdate ? this.currentSub : currentSub as Subscription?,
      selectedPlan: selectedPlan ?? this.selectedPlan,
      selectedBillingType: selectedBillingType ?? this.selectedBillingType,
      message: message == noUpdate ? this.message : message as String?,
      isLoading: isLoading ?? this.isLoading
  );

  @override
  List<Object?> get props => [currentSub, selectedPlan, selectedBillingType, message, isLoading];
}
