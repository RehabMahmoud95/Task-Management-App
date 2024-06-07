part of 'add_task_bloc.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

final class AddTaskInitial extends AddTaskState {}

final class AddTaskSuccessfully extends AddTaskState {
  final String taskID;
  AddTaskSuccessfully(this.taskID);
  @override
  List<Object> get props => [taskID];
}

final class AddTaskFailure extends AddTaskState {
  final String message;
  AddTaskFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class LoadingState extends AddTaskState {}
