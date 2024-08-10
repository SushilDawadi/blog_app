import 'package:blog_app/core/helper/app_helper.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_color.dart';

class BlogDetails extends StatelessWidget {
  final Blog blog;
  const BlogDetails({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(CupertinoIcons.back),
          ),
          forceMaterialTransparency: true,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'By ${blog.posterName ?? ""}',
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(convertDateFormat(blog.updatedAt.toString())),
                    Text(' - ${calculateReadingTime(blog.content)} min read'),
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: precacheImage(NetworkImage(blog.imageUrl), context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        height: size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(blog.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          color: AppColor.secondaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                      );
                    } else {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[600]!,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
