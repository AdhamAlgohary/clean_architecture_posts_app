import 'dart:convert';
import 'package:clean_architecture_posts_app/core/data_types.dart';
import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/core/strings/url.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<ListOfPostModel> getAllCachePosts();
  Future<Unit> cachedPosts(ListOfPostModel postModel);
}

class PostLocalDataSourceImplWithSharedPerfernces
    implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImplWithSharedPerfernces(
      {required this.sharedPreferences});
  @override
  Future<Unit> cachedPosts(ListOfPostModel postModel) {
    final List postModelToJson = postModel
        .map<ReturnedDataFromApi>((postModel) => postModel.toJson())
        .toList();

    sharedPreferences.setString(keyForCacheData, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<ListOfPostModel> getAllCachePosts() {
    final jsonString = sharedPreferences.getString(keyForCacheData);
    if (jsonString != null) {
      final List decodeJsonData = json.decode(jsonString);
      final ListOfPostModel jsonToPostModel = decodeJsonData
          .map<PostModel>((jsonPostMode) => PostModel.fromJson(jsonPostMode))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
