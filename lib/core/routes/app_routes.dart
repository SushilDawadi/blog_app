import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/add_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String addBlog = '/add-blog';
  static const String blog = '/blog';
  static const String blogDetail = '/blog-detail';
  static Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignupPage());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case addBlog:
        return MaterialPageRoute(builder: (_) => const AddBlogPage());
      case blog:
        return MaterialPageRoute(builder: (_) => const BlogPage());
      case blogDetail:
        final args = settings.arguments;
        if (args is Blog) {
          return MaterialPageRoute(
            builder: (_) => BlogDetails(blog: args),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No blog details available'),
            ),
          ),
        );

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
