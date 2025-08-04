import 'package:objectbox/objectbox.dart';

import '../../domain/models/billing_method.dart';
import '../../domain/models/billing_type.dart';
import '../../domain/models/subscription_plan.dart';
import '../../../shared/data/user_entity.dart';
import 'location_entity.dart';

@Entity()
class SubscriptionEntity{
  @Id()
  int id;

  bool isActive;
  @Property(type: PropertyType.date)
  DateTime startDate;
  @Property(type: PropertyType.date)
  DateTime endDate;

  @Transient()
  SubscriptionPlan? plan;
  @Transient()
  BillingType? billingType;
  @Transient()
  BillingMethod? billingMethod;

  final user = ToOne<UserEntity>();
  final location = ToOne<LocationEntity>();

  // Getters and setters for the transient properties (enums)
  int? get dbPlan => plan?.index;
  set dbPlan(int? value){
    plan = value == null ? null : SubscriptionPlan.values[value];
  }
  int? get dbBillingType => billingType?.index;
  set dbBillingType(int? value){
    billingType = value == null ? null : BillingType.values[value];
  }
  int? get dbBillingMethod => billingMethod?.index;
  set dbBillingMethod(int? value){
    billingMethod = value == null ? null : BillingMethod.values[value];
  }

  SubscriptionEntity({
    this.id = 0,
    required this.isActive,
    required this.startDate,
    required this.endDate,
  });
}