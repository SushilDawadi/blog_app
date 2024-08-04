import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String signUp = '/signUp';
  static const String login = '/login';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignupPage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
