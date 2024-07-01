import 'package:clean_architecture_posts_app/core/data_types.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostRepositories _repositories;
  GetAllPostsUseCase(this._repositories);
  Future<Either<Failure, ListOfPost>> call() async =>
      await _repositories.getAllPosts();
}
