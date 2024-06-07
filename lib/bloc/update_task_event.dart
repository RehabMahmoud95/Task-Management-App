part of 'update_task_bloc.dart';

sealed class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}

class UpdateTask extends UpdateTaskEvent {
  TaskModel task;
  UpdateTask(this.task);
  @override
  List<Object> get props => [task];
}
