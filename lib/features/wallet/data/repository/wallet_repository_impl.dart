import 'package:sub_tracker/core/storage/extension.dart';
import '../../../../core/error/error.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/util/response.dart';
import '../../../../core/util/safe_caller.dart';
import '../../domain/models/wallet.dart';
import '../../domain/repository/wallet_repository.dart';
import '../dao/wallet_dao.dart';
import '../mapper/transaction_mapper.dart';

class WalletRepositoryImpl extends WalletRepository{
  final WalletDao _walletDao;
  final SecureStorage _secureStorage;

  WalletRepositoryImpl(this._walletDao, this._secureStorage);

  @override
  Future<Response<void, DataError>> fundWallet(double amount) =>
      safeCall(() async{
        await Future.delayed(Duration(seconds: 2)); // simulate network request
        final userId = await _secureStorage.userId;
        return _walletDao.credit(userId, amount, "Wallet Top-up");
      });

  @override
  Future<Stream<Wallet>> getWalletStream() async{
    final response = await safeCall(() async{
      final userId = await _secureStorage.userId;
      return _walletDao.watchWallet(userId);
    });
    return switch(response){
      SuccessResponse(data:final walletStream) =>
          walletStream.map((wallet) => Wallet(
            balance: wallet.balance,
            totalBalanceThisMonth: wallet.transactions.totalBalanceThisMonth,
            transactions: wallet.transactions.reversed.map((entity) =>
                entity.toTransaction()
            ).toList()
          )),
      ErrorResponse(:final error) => Stream.error(error)
    };
  }


}