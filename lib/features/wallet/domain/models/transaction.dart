import 'package:equatable/equatable.dart';

import 'transaction_status.dart';
import 'transaction_type.dart';

class Transaction extends Equatable{
  final double amount;
  final String description;
  final DateTime date;
  final TransactionStatus status;
  final TransactionType type;

  const Transaction({
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.type
  });

  @override
  List<Object?> get props => [amount, description, date, status, type];

}