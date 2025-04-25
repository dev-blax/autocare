import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/main/shell_screen.dart';
import 'screens/main/home_screen.dart';
import 'screens/main/bookings_screen.dart';
import 'screens/main/service_history_screen.dart';
import 'screens/main/profile_screen.dart';

void main() {
  runApp(const AutoCareApp());
}

final _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
   
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          initialLocation: '/shell/home',
          routes: [
            GoRoute(
              path: '/shell/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/shell/bookings',
          routes: [
            GoRoute(
              path: '/shell/bookings',
              builder: (context, state) => const BookingsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/shell/history',
          routes: [
            GoRoute(
              path: '/shell/history',
              builder: (context, state) => const ServiceHistoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/shell/profile',
          routes: [
            GoRoute(
              path: '/shell/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class AutoCareApp extends StatelessWidget {
  const AutoCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: 'AutoCare',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        brightness: Brightness.light,
      ),
      routerConfig: _router,
    );
  }
}
