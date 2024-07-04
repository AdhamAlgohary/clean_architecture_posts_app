import 'package:clean_architecture_posts_app/core/data_types.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class PostRemoteDataSource {
  Future<ListOfPostModel> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
}
