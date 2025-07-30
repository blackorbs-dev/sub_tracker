import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/service/biometric_auth.dart';
import 'core/storage/secure_storage_impl.dart';
import 'features/auth/data/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/shared/data/database/database.dart';

class DependencyContainer extends StatelessWidget{
  const DependencyContainer({super.key, required this.database, required this.child});

  final Widget child;
  final AppDatabase database;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
              create: (_) => AuthRepositoryImpl(
                  database.userDao(),
                  SecureStorageImpl(),
                  BiometricAuth()
              )
          )
        ],
        child: child
    );
  }
}