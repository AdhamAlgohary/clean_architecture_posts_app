import 'package:clean_architecture_posts_app/core/data_types.dart';
import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/core/network/network_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_remote_data_source/post_remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepositoriesImpl extends PostRepositories {
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;
  final NetworkInfo networkInfo;
  PostRepositoriesImpl(this.networkInfo,
      {required this.postRemoteDataSource, required this.postLocalDataSource});

  @override
  Future<Either<Failure,ListOfPost>> getAllPosts() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remotePosts = await postRemoteDataSource.getAllPosts();
         postLocalDataSource.cachedPosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalDataSource.getAllCachePosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final postModel =
        PostModel(title: post.title, body: post.body);

    return await _getMessage(() => postRemoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() => postRemoteDataSource.deletePost(id));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => postRemoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
