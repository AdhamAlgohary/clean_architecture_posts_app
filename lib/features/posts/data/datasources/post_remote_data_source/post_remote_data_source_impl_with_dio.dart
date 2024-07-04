import 'package:clean_architecture_posts_app/core/data_types.dart';
import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/core/strings/end_points.dart';
import 'package:clean_architecture_posts_app/core/strings/url.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_remote_data_source/post_remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PostRemoteDataSourceImplWithDio implements PostRemoteDataSource {
  PostRemoteDataSourceImplWithDio();
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {"content-type": "application/json"},
  ));
  @override
  Future<ListOfPostModel> getAllPosts() async {
    final response = await dio.get(getPostEndPoint);
    final condition = response.statusCode == 200;
    if (condition) {
      final List data = response.data;
      final ListOfPostModel postModel =
          data.map<PostModel>(convertFromJsonToPostModel).toList();
      return postModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final data = {"title": postModel.title, "body": postModel.body};
    final response = await dio.post(addPostEndPoint, data: data);
    final condition = response.statusCode == 201;
    if (condition) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final queryParameters = {"id": postId};
    final response =
        await dio.delete(deletePostEndPoint, queryParameters: queryParameters);
    final condition = response.statusCode == 200;
    if (condition) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final data = {"title": postModel.title, "body": postModel.body};
    final queryParameters = {"id": postModel.id};
    final response = await dio.patch(updatePostEndPoint,
        data: data, queryParameters: queryParameters);
    final condition = response.statusCode == 200;
    if (condition) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
