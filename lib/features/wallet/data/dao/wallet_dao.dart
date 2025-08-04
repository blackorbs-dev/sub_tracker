import '../../../../core/error/error.dart';
import '../../../../generated/objectbox.g.dart';
import '../../domain/models/transaction_status.dart';
import '../../domain/models/transaction_type.dart';
import '../entity/transaction_entity.dart';
import '../entity/wallet_entity.dart';

class WalletDao{
  final Box<WalletEntity> _walletBox;

  WalletDao(Store store):
        _walletBox = store.box<WalletEntity>();

  Stream<WalletEntity> watchWallet(int userId) {
    return _walletBox.query(WalletEntity_.user.equals(userId))
        .watch(triggerImmediately: true)
        .map((q) => q.findFirst())
        .where((entity) => entity != null)
        .cast<WalletEntity>();
  }

  void credit(int userId, double amount, String description) {
    final wallet = _walletBox.query(WalletEntity_.user.equals(userId)).build().findFirst();
    if (wallet == null) throw CustomException("Wallet not found");

    _walletBox.put(
        wallet..balance += amount
          ..transactions.add(
              TransactionEntity(
                  amount: amount,
                  type: TransactionType.credit,
                  date: DateTime.now(),
                  description: description,
                  status: TransactionStatus.successful
              )
          )
    );
  }

  TransactionStatus debit(int userId, double amount, String description) {
    final wallet = _walletBox.query(WalletEntity_.user.equals(userId)).build().findFirst();
    if (wallet == null) throw CustomException("Wallet not found");

    final status = wallet.balance < amount ? TransactionStatus.failed
        : TransactionStatus.successful;
    if(status == TransactionStatus.successful) {
      wallet.balance -= amount;
    }
    _walletBox.put(
      wallet..transactions.add(
          TransactionEntity(
              amount: amount,
              type: TransactionType.debit,
              date: DateTime.now(),
              description: description,
              status: status
          )
      )
    );
    return status;
  }
}