import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:task_management_app/services/backend.dart';
part 'get_all_tasks_event.dart';
part 'get_all_tasks_state.dart';

class GetAllTasksBloc extends Bloc<GetAllTasksEvent, GetAllTasksState> {
  BackEnd backEnd;
  GetAllTasksBloc(this.backEnd) : super(LoadingState()) {
    on<GetAllTasksEvent>((event, emit) async {
      late StreamSubscription<ConnectivityResult> _connectivitySubscription;
      List<TaskModel> tasks = [];
      ConnectivityResult connectivityResult;
      // List<TaskModel> doneTasks = [];
      // List<TaskModel> notDoneTasks = [];
      emit(LoadingState());
      //
      try {
        connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult.name == "none") {
          emit(OfflineState("check your internet to Load data"));
        }
        else {
            tasks = await backEnd.getAllTasks();
            emit(LoadedState(tasks));
        }
        //       .onConnectivityChanged
        //       .listen((ConnectivityResult _result) async {
        //     print(
        //         "connectivity result from get all :::::::::::::::::::::::: ${_result.name}");

        //     if (_result.name == "none") {

        //       emit(OfflineState("check your internet to Load dat"));
        //     } else {
        //   tasks = await backEnd.getAllTasks();
        // emit(LoadedState(tasks));
        //     }
        //   });

        // for (TaskModel task in tasks) {
        //   if (task.isDone!) {
        //     doneTasks.add(task);
        //   } else {
        //     notDoneTasks.add(task);
        //   }
        // }
        // if (event is GetDoneTasks) {
        //   emit(DoneTasksState(doneTasks));
        // } else if (event is GetNotDoneTasks) {
        //   emit(NotDoneTasksState(notDoneTasks));
        // } else if (event is GetAllTasks) {
        //   emit(LoadedState(tasks));
        // }
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
