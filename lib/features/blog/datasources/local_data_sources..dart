import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogModel});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      final blogJson = box.get(i.toString());
      if (blogJson != null) {
        // Ensure the data is properly cast to Map<String, dynamic>
        final Map<String, dynamic> jsonMap =
            Map<String, dynamic>.from(blogJson as Map);
        blogs.add(BlogModel.fromJson(jsonMap));
      }
    }
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogModel}) {
    box.clear();
    for (int i = 0; i < blogModel.length; i++) {
      box.put(i.toString(), blogModel[i].toJson());
    }
  }
}
