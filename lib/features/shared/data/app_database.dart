import 'package:path_provider/path_provider.dart';
import '../../../generated/objectbox.g.dart';
import '../../subscription/data/dao/subscription_dao.dart';
import '../../wallet/data/dao/wallet_dao.dart';
import 'user_dao.dart';

class AppDatabase {
  late final Store _store;

  AppDatabase._(this._store);

  UserDao userDao() => UserDao(_store);
  WalletDao walletDao() => WalletDao(_store);
  SubscriptionDao subscriptionDao() => SubscriptionDao(_store);

  void close() => _store.close();

  static Future<AppDatabase> create({Store? store}) async {
    if(store != null){
      return AppDatabase._(store);
    }
    final dbPath = (await getApplicationDocumentsDirectory()).path;
    final Store appStore;
    if(Store.isOpen(dbPath)){
      appStore = Store.attach(getObjectBoxModel(), dbPath);
    }
    else {
      appStore = await openStore(directory: dbPath);
    }
    return AppDatabase._(appStore);
  }
}