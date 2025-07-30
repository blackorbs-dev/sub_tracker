import 'package:objectbox/objectbox.dart';

import '../../domain/transaction_status.dart';
import '../../domain/transaction_type.dart';
import 'wallet_entity.dart';

@Entity()
class TransactionEntity{
  @Id()
  int id;
  int amount;
  String description;
  @Property(type: PropertyType.date)
  DateTime date;

  @Transient()
  TransactionStatus? status;
  @Transient()
  TransactionType? type;

  final wallet = ToOne<WalletEntity>();

  int? get dbStatus => status?.index;
  set dbStatus(int? value){
    status = value == null ? null : TransactionStatus.values[value];
  }

  int? get dbType => type?.index;
  set dbType(int? value){
    type = value == null ? null : TransactionType.values[value];
  }

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.description,
    required this.date
  });

}