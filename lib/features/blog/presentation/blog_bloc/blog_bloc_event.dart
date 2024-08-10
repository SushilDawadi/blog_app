part of 'blog_bloc_bloc.dart';

@immutable
sealed class BlogBlocEvent {}

final class BlogUpload extends BlogBlocEvent {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  BlogUpload({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}

final class FetchAllBlogs extends BlogBlocEvent {}
