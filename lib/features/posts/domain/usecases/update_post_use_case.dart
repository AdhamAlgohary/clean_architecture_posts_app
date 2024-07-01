import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUseCase {
  final PostRepositories _repositories;
  UpdatePostUseCase(this._repositories);
  Future<Either<Failure, Unit>> call(Post post) async =>
      await _repositories.updatePost(post);
}