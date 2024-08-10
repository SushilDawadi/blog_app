import 'package:blog_app/core/common/loader.dart';
import 'package:blog_app/core/helper/app_helper.dart';
import 'package:blog_app/core/routes/app_routes.dart';
import 'package:blog_app/core/theme/app_color.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/features/blog/presentation/blog_bloc/blog_bloc_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBlocBloc>().add(FetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Blog Page',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.addBlog);
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogBlocBloc, BlogBlocState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showCustomSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogBlocLoading) {
            return const Center(
              child: CustomLoader(),
            );
          }
          if (state is BlogDisplaySucess) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.blogDetail,
                        arguments: blog,
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColor.secondaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...blog.topics.map((e) => Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Chip(
                                          side: const BorderSide(
                                            color: AppColor.primaryColor,
                                          ),
                                          color: const WidgetStatePropertyAll(
                                            AppColor.primaryColor,
                                          ),
                                          padding: EdgeInsets.all(1),
                                          label: Row(
                                            children: [
                                              Text(e),
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                FutureBuilder(
                                  future: precacheImage(
                                      NetworkImage(blog.imageUrl), context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Container(
                                        height: 100,
                                        width: 100,
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
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        blog.title,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              textAlign: TextAlign.left,
                                              '${calculateReadingTime(blog.content)} min '),
                                          Text(blog.posterName ?? "",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: Text('No Blogs'),
          );
        },
      ),
    );
  }
}
