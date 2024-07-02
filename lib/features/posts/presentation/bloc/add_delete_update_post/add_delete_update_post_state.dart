import 'package:equatable/equatable.dart';

class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object?> get props => [];
}

class AddDeleteUpdatePostIntial extends AddDeleteUpdatePostState {}

class AddDeleteUpdatePostLoading extends AddDeleteUpdatePostState {
  const AddDeleteUpdatePostLoading();
}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;
  const ErrorAddDeleteUpdatePostState({required this.message});
  @override
  List<Object?> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
  final String message;

  const MessageAddDeleteUpdatePostState({required this.message});
  @override
  List<Object?> get props => [message];
}
