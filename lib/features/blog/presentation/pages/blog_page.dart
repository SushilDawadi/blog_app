import 'package:blog_app/core/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blog Page',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.add_blog);
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: const Center(
        child: Text('Blog Page'),
      ),
    );
  }
}
