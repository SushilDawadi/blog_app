import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/helper/connection_checker.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/datasources/local_data_sources..dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final BlogLocalDataSource blogLocalDataSource;

  BlogRepositoryImpl(this.connectionChecker, this.blogLocalDataSource,
      {required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return Left(Failure("No internet connection"));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        topics: topics,
        imageUrl: "",
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadImage(
        image: image,
        blog: blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBloc = await blogRemoteDataSource.uploadBlog(blogModel);
      return Right(uploadedBloc);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return Right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogModel: blogs);
      return Right(blogs);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
