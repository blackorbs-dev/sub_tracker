import 'package:sub_tracker/core/storage/extension.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/util/response.dart';
import '../../../core/util/safe_caller.dart';
import '../domain/account_repository.dart';
import 'user_dao.dart';

class AccountRepositoryImpl extends AccountRepository{
  final UserDao userDao;
  final SecureStorage secureStorage;

  AccountRepositoryImpl(this.userDao, this.secureStorage);

  @override
  Future<String?> getUserName() async{
    final response = await safeCall(() async{
      final user = userDao.get(await secureStorage.userId);
      return user?.name;
    });
    if(response case SuccessResponse(data:final name)) return name;
    return null;
  }

}