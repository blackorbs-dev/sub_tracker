import '../../subscription/domain/models/subscription.dart';

class CurrentSubscription extends Subscription{

  const CurrentSubscription({
    required super.isActive,
    required super.startDate,
    required super.location,
    required super.plan,
    required super.billingType,
    required super.billingMethod,
    required super.endDate,
    required this.daysLeft,
    required this.usedDaysProgress
  });

  final int daysLeft;
  final double usedDaysProgress;

}