import 'package:clean_architecture_posts_app/core/data_types.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';


class PostModel extends Post {
  const PostModel(
      { super.id, required super.title, required super.body});

      

  factory PostModel.fromJson(ReturnedDataFromApi json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }
  ReturnedDataFromApi toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}
