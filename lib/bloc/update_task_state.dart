part of 'update_task_bloc.dart';

sealed class UpdateTaskState extends Equatable {
  const UpdateTaskState();

  @override
  List<Object> get props => [];
}

final class UpdateTaskInitial extends UpdateTaskState {}

final class UpdateTaskSuccessfully extends UpdateTaskState {}

final class UpdateTaskFailure extends UpdateTaskState {
  final String message;
  const UpdateTaskFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class LoadingState extends UpdateTaskState {}
