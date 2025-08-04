import 'package:sub_tracker/features/wallet/domain/models/transaction_status.dart';

import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_type.dart';
import '../entity/transaction_entity.dart';

extension ToTransaction on TransactionEntity{
  Transaction toTransaction() => Transaction(
    amount: amount,
    description: description,
    date: date,
    status: status!,
    type: type!
  );
}

extension TotalBalance on List<TransactionEntity>{
  double get totalBalanceThisMonth{
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    return where((tx) =>
      tx.status == TransactionStatus.successful
          && (tx.date.isAfter(startOfMonth)
          || tx.date.isAtSameMomentAs(startOfMonth))
    )
        .fold(0.0, (total, tx) {
          if (tx.type == TransactionType.credit) {
            return total + tx.amount;
          } else if (tx.type == TransactionType.debit) {
            return total - tx.amount;
          }
          return total;
    });
  }
}