import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/core/strings/failure_msgs.dart';
import 'package:clean_architecture_posts_app/core/strings/sucess_msgs.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/add_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/delete_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/update_post_use_case.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_state.dart';
import 'package:dartz/dartz.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdatePostIntial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(const AddDeleteUpdatePostLoading());
        final addPostEvent = await addPost(event.posts);
        emit(_eitherDoneMessageOrErrorState(addPostEvent, addSuccessMsg));
      } else if (event is UpdatePostEvent) {
        emit(const AddDeleteUpdatePostLoading());
        final updatePostEvent = await updatePost(event.posts);
        emit(_eitherDoneMessageOrErrorState(updatePostEvent, updateSuccessMsg));
      } else if (event is DeletePostEvent) {
        emit(const AddDeleteUpdatePostLoading());
        final deletePostEvent = await deletePost(event.postId);
        emit(_eitherDoneMessageOrErrorState(deletePostEvent, deleteSuccessMsg));
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
