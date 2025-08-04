import '../error/error.dart';
import 'secure_keys.dart';
import 'secure_storage.dart';

extension UserId on SecureStorage{

  Future<int> get userId async{
    final idStr = await read(SecureKeys.accessToken);
    if (idStr == null) throw CustomException("No access token found");
    return int.parse(idStr);
  }
}