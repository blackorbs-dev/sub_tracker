import '../../../core/error/error.dart';
import '../../../core/util/response.dart';
import 'auth_info.dart';

abstract class AuthRepository{
  Future<Response<Null, DataError>> biometricLogin();
  Future<Response<Null, DataError>> login(AuthInfo authInfo);
  Future<Response<Null, DataError>> signup(AuthInfo authInfo);
}