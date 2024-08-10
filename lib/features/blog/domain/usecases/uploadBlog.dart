import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:dartz/dartz.dart';

class Uploadblog implements Usecase<Blog, uploadBlogParams> {
  final BlogRepository blogRepository;

  Uploadblog({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(uploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class uploadBlogParams {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  uploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}
