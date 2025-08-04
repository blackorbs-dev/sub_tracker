import 'package:objectbox/objectbox.dart';

import '../../domain/models/transaction_status.dart';
import '../../domain/models/transaction_type.dart';
import 'wallet_entity.dart';

@Entity()
class TransactionEntity{
  @Id()
  int id;
  double amount;
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
    this.id = 0,
    required this.amount,
    required this.description,
    required this.date,
    this.status, this.type
  });

}