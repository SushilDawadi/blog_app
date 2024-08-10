import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';

import 'package:blog_app/features/blog/domain/usecases/uploadBlog.dart';

import 'package:meta/meta.dart';

part 'blog_bloc_event.dart';
part 'blog_bloc_state.dart';

class BlogBlocBloc extends Bloc<BlogBlocEvent, BlogBlocState> {
  final Uploadblog uploadBlog;
  final GetAllBlogs fetchAllBlogs;
  BlogBlocBloc(this.uploadBlog, this.fetchAllBlogs) : super(BlogBlocInitial()) {
    on<BlogBlocEvent>((event, emit) => emit(BlogBlocLoading()));
    on<BlogUpload>(_uploadBlog);
    on<FetchAllBlogs>(_fetchAllBlogs);
  }

  void _uploadBlog(BlogUpload event, Emitter<BlogBlocState> emit) async {
    final res = await uploadBlog(
      uploadBlogParams(
          image: event.image,
          title: event.title,
          content: event.content,
          posterId: event.posterId,
          topics: event.topics),
    );

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogUploadSucess(),
      ),
    );
  }

  void _fetchAllBlogs(FetchAllBlogs event, Emitter<BlogBlocState> emit) async {
    final res = await fetchAllBlogs(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(
        BlogDisplaySucess(r),
      ),
    );
  }
}
