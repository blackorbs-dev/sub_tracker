import 'package:equatable/equatable.dart';

import 'billing_method.dart';
import 'billing_type.dart';
import 'location.dart';
import 'subscription_plan.dart';

class Subscription extends Equatable{

  final bool isActive;
  final DateTime startDate;
  final DateTime endDate;
  final Location? location;
  final SubscriptionPlan plan;
  final BillingType billingType;
  final BillingMethod billingMethod;

  const Subscription({
    required this.isActive,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.plan,
    required this.billingType,
    required this.billingMethod
  });

  @override
  List<Object?> get props => [isActive, startDate, endDate, location, plan, billingType, billingMethod];

  @override
  bool get stringify => true;

}