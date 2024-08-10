part of 'blog_bloc_bloc.dart';

@immutable
sealed class BlogBlocState {}

final class BlogBlocInitial extends BlogBlocState {}

final class BlogBlocLoading extends BlogBlocState {}

final class BlogFailure extends BlogBlocState {
  final String message;

  BlogFailure(this.message);
}

final class BlogUploadSucess extends BlogBlocState {}

final class BlogDisplaySucess extends BlogBlocState {
  final List<Blog> blogs;

  BlogDisplaySucess(this.blogs);
}
