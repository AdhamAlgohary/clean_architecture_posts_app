import 'dart:convert';

import 'package:clean_architecture_posts_app/core/data_types.dart';
import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/core/strings/end_points.dart';
import 'package:clean_architecture_posts_app/core/strings/url.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<ListOfPostModel> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
}

class PostRemoteDataSourceImplWithHttp implements PostRemoteDataSource {
  final http.Client client;
  static const headers = {"Content-Type": "application/json"};
  PostRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<ListOfPostModel> getAllPosts() async {
    const completeUrl = '$baseUrl$getPostEndPoint';
    final response = await client.get(Uri.parse(completeUrl), headers: headers);
    final condition = response.statusCode == 200;
    if (condition) {
      final List decodedJson = json.decode(response.body) as List;
      final ListOfPostModel postModel =
          decodedJson.map<PostModel>(convertFromJsonToPostModel).toList();
      return postModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    const completeUrl = '$baseUrl$addPostEndPoint';
    final response = await client.post(Uri.parse(completeUrl), body: body);
    final condition = response.statusCode == 201;

    if (condition) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final completeUrl = '$baseUrl$deletePostEndPoint$postId';
    final response =
        await client.delete(Uri.parse(completeUrl), headers: headers);
    final condition = response.statusCode == 200;
    if (condition) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final completeUrl = '$baseUrl$updatePostEndPoint${postModel.id}';
    final body = {"title": postModel.title, "body": postModel.body};
    final response = await client.patch(Uri.parse(completeUrl), body: body);
    final condition = response.statusCode == 200;
    if (condition) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
