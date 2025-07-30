import 'package:objectbox/objectbox.dart';

import 'transaction_entity.dart';
import 'user_entity.dart';

@Entity()
class WalletEntity{
  @Id()
  int id;

  double balance;
  final user = ToOne<UserEntity>();
  final transactions = ToMany<TransactionEntity>();

  WalletEntity({
    required this.id,
    required this.balance
  });

}