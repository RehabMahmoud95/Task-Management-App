part of 'delete_task_bloc.dart';

sealed class DeleteTaskState extends Equatable {
  const DeleteTaskState();
  
  @override
  List<Object> get props => [];
}

final class DeleteTaskInitial extends DeleteTaskState {}


final class DeleteTaskSuccessfully extends DeleteTaskState {

}

final class DeleteTaskFailure extends DeleteTaskState {
  final String message;
  const DeleteTaskFailure(this.message);
   @override
  List<Object> get props => [message];
}

final class LoadingState extends DeleteTaskState {}
