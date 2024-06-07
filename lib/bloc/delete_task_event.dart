part of 'delete_task_bloc.dart';

sealed class DeleteTaskEvent extends Equatable {
  const DeleteTaskEvent();

  @override
  List<Object> get props => [];
}

class DeleteTask extends DeleteTaskEvent {
  final TaskModel task;

  const DeleteTask({required this.task});
  @override
  List<Object> get props => [task];
}
