import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/theme/theme_cubit.dart';

import '../features/auth/data/auth_repository_impl.dart';
import '../features/auth/domain/auth_repository.dart';
import '../features/shared/data/account_repository_impl.dart';
import '../features/shared/data/app_database.dart';
import '../features/shared/domain/account_repository.dart';
import '../features/subscription/data/repository/subscription_repository_impl.dart';
import '../features/subscription/domain/repository/subscription_repository.dart';
import '../features/wallet/data/repository/wallet_repository_impl.dart';
import '../features/wallet/domain/repository/wallet_repository.dart';
import 'get_it.dart';

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
                  userDao: database.userDao(),
                  walletDao: database.walletDao(),
                  secureStorage:  getIt(),
                  biometricAuth:  getIt()
              )
          ),
          RepositoryProvider<AccountRepository>(
              create: (_) => AccountRepositoryImpl(
                  database.userDao(), getIt()
              )
          ),
          RepositoryProvider<WalletRepository>(
              create: (_) => WalletRepositoryImpl(
                  database.walletDao(), getIt()
              )
          ),
          RepositoryProvider<SubscriptionRepository>(
              create: (_) => SubscriptionRepositoryImpl(
                  subscriptionDao: database.subscriptionDao(),
                  walletDao: database.walletDao(),
                  secureStorage: getIt()
              )
          ),
        ],
        child: BlocProvider(
          create: (context) => ThemeCubit(context.read()),
          child: child,
        )
    );
  }
}