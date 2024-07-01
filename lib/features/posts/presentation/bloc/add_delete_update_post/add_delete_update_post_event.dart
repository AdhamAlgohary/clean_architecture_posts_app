import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();
  @override
  List<Object?> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostEvent {
  final Post posts;
  const AddPostEvent({required this.posts});
  @override
  List<Object?> get props => [posts];
}

class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  final Post posts;
  const UpdatePostEvent({required this.posts});
  @override
  List<Object?> get props => [posts];
}

class DeletePostEvent extends AddDeleteUpdatePostEvent {
  final int postId;
  const DeletePostEvent({required this.postId});
  @override
  List<Object?> get props => [postId];
}
