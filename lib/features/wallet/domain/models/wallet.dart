import 'package:equatable/equatable.dart';

import 'transaction.dart';

class Wallet extends Equatable{

  final double balance;
  final double totalBalanceThisMonth;
  final List<Transaction> transactions;

  const Wallet({
    required this.balance,
    required this.totalBalanceThisMonth,
    required this.transactions
  });

  @override
  List<Object?> get props => [balance, totalBalanceThisMonth, transactions];

}