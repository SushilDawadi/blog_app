import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:dartz/dartz.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
}
