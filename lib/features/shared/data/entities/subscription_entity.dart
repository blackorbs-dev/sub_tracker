import 'package:objectbox/objectbox.dart';

import '../../domain/billing_type.dart';
import '../../domain/subscription_plan.dart';
import 'user_entity.dart';

@Entity()
class SubscriptionEntity{
  @Id()
  int id;

  String location;
  @Property(type: PropertyType.date)
  DateTime startDate;
  bool isActive;

  @Transient()
  SubscriptionPlan? plan;
  @Transient()
  BillingType? billingType;

  final user = ToOne<UserEntity>();

  int? get dbPlan => plan?.index;
  set dbPlan(int? value){
    plan = value == null ? null : SubscriptionPlan.values[value];
  }
  int? get dbBillingType => billingType?.index;
  set dbBillingType(int? value){
    billingType = value == null ? null : BillingType.values[value];
  }

  SubscriptionEntity({
    required this.id,
    required this.location,
    required this.startDate,
    required this.isActive
  });

}