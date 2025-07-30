import '../../../../generated/objectbox.g.dart';
import '../dao/user_dao.dart';

class AppDatabase {
  late final Store _store;

  AppDatabase._(this._store);

  static Future<AppDatabase> create({Store? store}) async {
    return AppDatabase._(store ?? await openStore());
  }

  UserDao userDao() => UserDao(_store);

  void close() => _store.close();
}