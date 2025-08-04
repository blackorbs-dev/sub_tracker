import 'package:objectbox/objectbox.dart';

import '../../../shared/data/user_entity.dart';
import 'transaction_entity.dart';

@Entity()
class WalletEntity{
  @Id()
  int id;

  double balance;
  final user = ToOne<UserEntity>();
  final transactions = ToMany<TransactionEntity>();

  WalletEntity({
    this.id = 0,
    this.balance = 0
  });

}