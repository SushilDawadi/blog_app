import 'package:blog_app/features/blog/domain/entity/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.posterId,
      required super.title,
      required super.content,
      required super.topics,
      required super.imageUrl,
      required super.updatedAt});

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    List<String>? topics,
    String? imageUrl,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  //from json

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
        id: json['id'],
        posterId: json['poster_id'],
        title: json['title'],
        content: json['content'],
        topics: List<String>.from(json['topics'] ?? []),
        imageUrl: json['image_url'],
        updatedAt: json['updated_at'] == null
            ? DateTime.now()
            : DateTime.parse(json['updated_at']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posterId': posterId,
      'title': title,
      'content': content,
      'topics': topics,
      'imageUrl': imageUrl,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
