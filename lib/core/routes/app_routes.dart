import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/presentation/pages/add_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String add_blog = '/add-blog';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignupPage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case add_blog:
        return MaterialPageRoute(builder: (_) => const AddBlogPage());
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
