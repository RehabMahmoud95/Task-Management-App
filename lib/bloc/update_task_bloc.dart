import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:task_management_app/services/backend.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  BackEnd backEnd;
  UpdateTaskBloc(this.backEnd) : super(UpdateTaskInitial()) {
    on<UpdateTaskEvent>((event, emit) async {
      try {
        emit(LoadingState());
        if (event is UpdateTask) {
          await backEnd.updateTask(event.task);
          print(" task update successfully.........................");
          emit(UpdateTaskSuccessfully());
        }
      } catch (e) {
        emit(UpdateTaskFailure("Sorry, task can't be updated"));
      }
    });
  }
}
