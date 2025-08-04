import 'package:get_it/get_it.dart';
import '../core/service/biometric_auth.dart';
import '../core/storage/secure_storage.dart';
import '../core/storage/secure_storage_impl.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorageImpl());

  getIt.registerLazySingleton<BiometricAuth>(() => BiometricAuth());
}