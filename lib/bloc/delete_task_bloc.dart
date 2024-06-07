import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:task_management_app/services/backend.dart';

part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  BackEnd backEnd;
  DeleteTaskBloc(this.backEnd) : super(DeleteTaskInitial()) {
    on<DeleteTaskEvent>((event, emit) async {
      try {
        emit(LoadingState());
        if (event is DeleteTask) {
          await backEnd.deleteTask(event.task);
          print(" task deleted successfully.........................");
          emit(DeleteTaskSuccessfully());
        }
      } catch (e) {
        emit(DeleteTaskFailure("something occure: ${e.toString()}"));
      }
    });
  }
}
