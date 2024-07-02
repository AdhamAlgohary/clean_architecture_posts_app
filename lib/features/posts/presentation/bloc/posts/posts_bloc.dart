import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/core/strings/failure_msgs.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_events.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  List<Post> posts=[];
  Post? post;

  PostsBloc({required this.getAllPosts}) : super(PostsIntial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final postsOrFailure = await getAllPosts();
        emit(_mapFailureOrPostsToState(postsOrFailure));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case OffLineFailure():
        return offLineFailureMsg;
      case ServerFailure():
        return serverFailureMsg;
      case EmptyCacheFailure():
        return emptyCacheFailureMsg;
      default:
        return "Unexpected error ,Please try again later";
    }
  }
}
