import 'package:go_router/go_router.dart';
import 'package:gold_caurd_app/features/auth/login_Screen.dart';
import 'package:gold_caurd_app/features/auth/register_screen.dart';
import 'package:gold_caurd_app/features/home/views/home_screen.dart';
import 'package:gold_caurd_app/features/main_screen/main_screen.dart';
import 'package:gold_caurd_app/features/splash_screen/splash_screen.dart';

import 'app_routes.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRoutes.registerScreen,
        path: AppRoutes.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.mainScreen,
        path: AppRoutes.mainScreen,
        builder: (context, state) => MainScreen(),
      ),
    ],
  );
}
