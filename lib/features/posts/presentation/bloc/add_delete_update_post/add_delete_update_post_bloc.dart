import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/core/strings/failure_msgs.dart';
import 'package:clean_architecture_posts_app/core/strings/sucess_msgs.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/add_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/delete_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/update_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  bool? isUpdated;
  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdatePostIntial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      switch (event) {
        case AddPostEvent _:
          {
            emit(const AddDeleteUpdatePostLoading());
            final addPostEvent = await addPost(event.posts);
            emit(_eitherDoneMessageOrErrorState(addPostEvent, addSuccessMsg));
            break;
          }
        case UpdatePostEvent _:
          {
            emit(const AddDeleteUpdatePostLoading());
            final updatePostEvent = await updatePost(event.posts);
            emit(_eitherDoneMessageOrErrorState(
                updatePostEvent, updateSuccessMsg));
            break;
          }
        case DeletePostEvent _:
          {
            emit(const AddDeleteUpdatePostLoading());
            final deletePostEvent = await deletePost(event.postId);
            emit(_eitherDoneMessageOrErrorState(
                deletePostEvent, deleteSuccessMsg));
            break;
          }
        default:
      }
    });
  }
  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => ErrorAddDeleteUpdatePostState(
            message: _mapFailureToMessage(failure)),
        (_) => MessageAddDeleteUpdatePostState(message: message));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OffLineFailure():
        return offLineFailureMsg;
      case ServerFailure():
        return serverFailureMsg;
      default:
        return "Unexpected error , Please try again later";
    }
  }
}
