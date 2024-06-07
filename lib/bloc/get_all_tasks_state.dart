part of 'get_all_tasks_bloc.dart';

sealed class GetAllTasksState extends Equatable {
  const GetAllTasksState();

  @override
  List<Object> get props => [];
}

class LoadingState extends GetAllTasksState {}

class OfflineState extends GetAllTasksState {
  String message;
  OfflineState(this.message);
  @override
  List<Object> get props => [message];
}

class LoadedState extends GetAllTasksState {
  final List<TaskModel> tasks;
  const LoadedState(this.tasks);
  @override
  List<Object> get props => [tasks];
}
// class DoneTasksState extends GetAllTasksState {
//   final List<TaskModel> doneTasks;
//   const DoneTasksState(this.doneTasks);
//   @override
//   List<Object> get props => [doneTasks];
// }

// class NotDoneTasksState extends GetAllTasksState {
//   final List<TaskModel> notDoneTasks;
//   const NotDoneTasksState(this.notDoneTasks);
//   @override
//   List<Object> get props => [notDoneTasks];
// }
class ErrorState extends GetAllTasksState {
  final String message;
  const ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
