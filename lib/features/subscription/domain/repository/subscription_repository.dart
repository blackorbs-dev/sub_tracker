import '../../../../core/error/error.dart';
import '../../../../core/util/response.dart';
import '../models/auto_renew_status.dart';
import '../models/billing_method.dart';
import '../models/billing_type.dart';
import '../models/subscription.dart';
import '../models/subscription_plan.dart';

abstract class SubscriptionRepository{
  /// Quarterly subscription discount in percentage
  static const discount = 17;
  Future<Stream<Subscription?>> getCurrentSubscription();
  Future<Stream<List<Subscription>>> getAllSubscription();
  Future<Response<void, DataError>> cancelSubscription();
  /// Subtracts one day from current subscription to simulate one day has passed
  Future<Response<void, DataError>> adjustCurrentSubStartDate();
  Future<Response<void, DataError>> subscribe(
    SubscriptionPlan plan, BillingType billingType, BillingMethod billingMethod
  );
  Future<Response<AutoRenewStatus, DataError>> renewCurrentSubscription();
}