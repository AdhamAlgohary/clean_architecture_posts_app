import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/post_repositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostRepositories _repositories;
  DeletePostUseCase(this._repositories);
  Future<Either<Failure, Unit>> call(int postId) async =>
      await _repositories.deletePost(postId);
}
