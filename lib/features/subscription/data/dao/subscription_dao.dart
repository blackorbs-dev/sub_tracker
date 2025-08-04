import '../../../../generated/objectbox.g.dart';
import '../entity/subscription_entity.dart';

class SubscriptionDao {
  final Box<SubscriptionEntity> _subscriptionBox;

  SubscriptionDao(Store store) :
        _subscriptionBox = store.box<SubscriptionEntity>();

  int insert(SubscriptionEntity subscription) =>
      _subscriptionBox.put(subscription);

  SubscriptionEntity? getCurrentSubscription(int userId) {
    return _subscriptionBox.query(
      SubscriptionEntity_.user.equals(userId) &
      SubscriptionEntity_.isActive.equals(true),
    ).build().findFirst();
  }

  Stream<SubscriptionEntity?> watchCurrentSubscription(int userId) {
    return _subscriptionBox.query(
      SubscriptionEntity_.user.equals(userId) &
      SubscriptionEntity_.isActive.equals(true),
    ).watch(triggerImmediately: true)
        .map((q) => q.findFirst());
  }

  Stream<List<SubscriptionEntity>> watchAllSubscriptions(int userId) {
    return _subscriptionBox.query(
      SubscriptionEntity_.user.equals(userId),
    ).order(SubscriptionEntity_.startDate, flags: Order.descending)
        .watch(triggerImmediately: true)
        .map((q) => q.find());
  }
}
