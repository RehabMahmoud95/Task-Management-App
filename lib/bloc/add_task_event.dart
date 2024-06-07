part of 'add_task_bloc.dart';

sealed class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends AddTaskEvent {
  final String? taskID;
  final TaskModel task;
  const AddTask(this.task, {this.taskID});
  @override
  List<Object> get props => [task];
}
