import 'package:objectbox/objectbox.dart';

import '../../subscription/data/entity/subscription_entity.dart';
import '../../wallet/data/entity/wallet_entity.dart';

@Entity()
class UserEntity{
  @Id()
  int id;

  String name;
  String email;
  String password;

  final wallet = ToOne<WalletEntity>();
  final subscriptions = ToMany<SubscriptionEntity>();

  UserEntity({
    this.id = 0,
    required this.name,
    required this.email,
    required this.password
  });

}