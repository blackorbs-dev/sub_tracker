import '../../domain/models/subscription.dart';
import '../entity/subscription_entity.dart';
import 'location_mapper.dart';

extension SubscriptionX on SubscriptionEntity {
  Subscription toModel() => Subscription(
      isActive: isActive,
      startDate: startDate,
      endDate: endDate,
      location: location.target?.toModel(),
      plan: plan!,
      billingType: billingType!,
      billingMethod: billingMethod!
  );

  bool get isExpired => DateTime.now().isAfter(endDate);
  bool get isPendingAutoRenew => endDate.difference(DateTime.now()).inDays <= 3;
}

extension Expiration on Subscription{
  int get daysLeft {
    final now = DateTime.now();
    final diff = endDate.difference(now).inDays;
    return diff > 0 ? diff : 0;
  }
  bool get isExpired => DateTime.now().isAfter(endDate);
}