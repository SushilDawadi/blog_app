import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage({required File image, required BlogModel blog});
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient client;

  BlogRemoteDataSourceImpl({required this.client});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response =
          await client.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(response.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage(
      {required File image, required BlogModel blog}) async {
    try {
      await client.storage.from('blog_images').upload(blog.id, image);

      return client.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await client.from('blogs').select(
            '*,profiles (name)',
          );
      return blogs
          .map((blog) => BlogModel.fromJson(blog).copyWith(
                posterName: blog['profiles']['name'],
              ))
          .toList();
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
