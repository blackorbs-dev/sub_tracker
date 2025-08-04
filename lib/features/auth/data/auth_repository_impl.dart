import '../../../core/error/error.dart';
import '../../../core/service/biometric_auth.dart';
import '../../../core/storage/secure_keys.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/util/response.dart';
import '../../shared/data/user_dao.dart';
import '../../wallet/data/dao/wallet_dao.dart';
import '../domain/auth_info.dart';
import '../domain/auth_repository.dart';
import 'auth_info_mapper.dart';

class AuthRepositoryImpl extends AuthRepository{
  final UserDao _userDao;
  final WalletDao _walletDao;
  final SecureStorage _secureStorage;
  final BiometricAuth _biometricAuth;

  AuthRepositoryImpl({
    required UserDao userDao,
    required WalletDao walletDao,
    required SecureStorage secureStorage, required BiometricAuth biometricAuth
  }): _userDao = userDao, _walletDao = walletDao,
        _secureStorage = secureStorage,
        _biometricAuth = biometricAuth;

  @override
  Future<Response<Null, DataError>> login(AuthInfo authInfo) async{
    await Future.delayed(const Duration(seconds: 2)); // simulate network request
    final user = _userDao.getByEmail(authInfo.email);
    if(user == null || user.password != authInfo.password){
      return Response.error(DataError.invalidCredentials());
    }
    await _secureStorage.write(SecureKeys.accessToken, user.id.toString());
    return Response.success(null);
  }

  @override
  Future<Response<Null, DataError>> signup(AuthInfo authInfo) async{
    await Future.delayed(const Duration(seconds: 2)); // simulate network request
    final user = _userDao.getByEmail(authInfo.email);
    if(user != null){
      return Response.error(DataError.message('User already exists'));
    }
    final userId = _userDao.insert(authInfo.toUserEntity());
    _walletDao.credit(userId, 20, 'Sign Up Bonus');
    await _secureStorage.write(SecureKeys.accessToken, userId.toString());
    return Response.success(null);
  }

  @override
  Future<Response<Null, DataError>> biometricLogin() async{
    final userId = await _secureStorage.read(SecureKeys.accessToken);
    if(userId == null){
      return Response.error(DataError.message('Please login to activate biometric feature'));
    }
    if(!await _biometricAuth.hasBiometrics()){
      return Response.error(DataError.message('Biometric feature is not supported'));
    }
    if(!await _biometricAuth.authenticate()){
      return Response.error(DataError.message('Could not authenticate using biometric, please try again later'));
    }
    if(_userDao.get(int.parse(userId)) == null){
      return Response.error(DataError.unknown());
    }
    return Response.success(null);
  }

}