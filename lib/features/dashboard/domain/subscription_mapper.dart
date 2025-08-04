import 'package:collection/collection.dart';
import '../../subscription/domain/models/billing_method.dart';
import '../../subscription/domain/models/location.dart';
import '../../subscription/domain/models/subscription.dart';
import '../../subscription/data/mapper/subscription_mapper.dart';
import 'current_subscription.dart';
import 'subscription_overview.dart';

extension AsCurrent on Subscription{
  CurrentSubscription get asCurrent {
    final daysLeft = this.daysLeft;
    final totalDays = endDate.difference(startDate).inDays;

    return CurrentSubscription(
        isActive: isActive && !isExpired,
        startDate: startDate,
        location: location,
        plan: plan,
        billingType: billingType,
        billingMethod: billingMethod,
        endDate: endDate,
        daysLeft: daysLeft,
        usedDaysProgress: (totalDays - daysLeft)/totalDays
    );
  }
}

extension SubscriptionListX on List<Subscription> {
  SubscriptionOverview? toOverview() {
    if(isEmpty) return null;
    final totalLocations = map((sub) => sub.location)
        .whereType<Location>().toSet().length;

    final totalRenewals =
        where((sub) => sub.billingMethod == BillingMethod.autoRenewed).length;

    final activeSub = firstWhereOrNull((sub) => sub.isActive);

    final daysLeft = (activeSub != null && !activeSub.isExpired)
        ? activeSub.daysLeft : 0;

    return SubscriptionOverview(
      totalLocations: totalLocations,
      totalRenewals: totalRenewals,
      daysLeft: daysLeft,
    );
  }
}
