import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/signup_screen.dart';
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
    ]
);