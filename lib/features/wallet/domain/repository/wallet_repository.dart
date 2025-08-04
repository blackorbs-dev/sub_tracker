import '../../../../core/error/error.dart';
import '../../../../core/util/response.dart';
import '../models/wallet.dart';

abstract class WalletRepository{
  Future<Stream<Wallet>> getWalletStream();
  Future<Response<void, DataError>> fundWallet(double amount);
}