import 'package:go_router/go_router.dart';
import 'package:sub_tracker/features/subscription/presentation/pages/sub_history_screen.dart';
import 'package:sub_tracker/features/subscription/presentation/pages/subscribe_screen.dart';
import 'package:sub_tracker/features/wallet/presentation/pages/wallet_screen.dart';

import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/signup_screen.dart';
import '../features/dashboard/presentation/pages/dashboard_screen.dart';
import 'routes.dart';
import 'transition_builders.dart';

final router = GoRouter(
    initialLocation: Screen.login,
    routes: [
      ShellRoute(
        pageBuilder: (context, state, child) =>
            fadeTransition(key: state.pageKey, child: child),
        routes: [
          GoRoute(
              path: Screen.login,
              pageBuilder: (context, state) => fadeTransition(
                  key: state.pageKey,
                  child: const LoginScreen()
              )
          ),
          GoRoute(
              path: Screen.signup,
              pageBuilder: (context, state) => fadeTransition(
                  key: state.pageKey,
                  child: const SignupScreen()
              )
          ),
        ],
      ),
      GoRoute(
          path: Screen.dashboard,
          pageBuilder: (context, state) => slideTransition(
              key: state.pageKey,
              child: const DashboardScreen()
          )
      ),
      GoRoute(
          path: Screen.wallet,
          pageBuilder: (context, state) => slideTransition(
              key: state.pageKey,
              child: const WalletScreen()
          )
      ),
      GoRoute(
          path: Screen.subscribe,
          pageBuilder: (context, state) => slideTransition(
              key: state.pageKey,
              child: const SubscribeScreen()
          )
      ),
      GoRoute(
          path: Screen.subHistory,
          pageBuilder: (context, state) => slideTransition(
              key: state.pageKey,
              child: const SubHistoryScreen()
          )
      ),
    ]
);