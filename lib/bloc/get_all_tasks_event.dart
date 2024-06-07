part of 'get_all_tasks_bloc.dart';

sealed class GetAllTasksEvent extends Equatable {
  const GetAllTasksEvent();

  @override
  List<Object> get props => [];
}

class GetAllTasks extends GetAllTasksEvent {}



// class GetDoneTasks extends GetAllTasksEvent {}

// class GetNotDoneTasks extends GetAllTasksEvent {}
