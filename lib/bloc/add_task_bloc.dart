import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:task_management_app/services/backend.dart';
import 'package:task_management_app/services/localDB.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  BackEnd backEnd;

  AddTaskBloc(this.backEnd) : super(AddTaskInitial()) {
    on<AddTaskEvent>((event, emit) async {
      late StreamSubscription<ConnectivityResult> _connectivitySubscription;
      ConnectivityResult connectivityResult;
      try {
        emit(LoadingState());
        if (event is AddTask) {
          connectivityResult = await Connectivity().checkConnectivity();
          // .onConnectivityChanged
          //     .listen((ConnectivityResult _result) async {
          //   print(
          //       "connectivity result :::::::::::::::::::::::: ${_result.name}");

          if (connectivityResult.name == "none") {
            LocalDB().saveTaskData(event.task).then((value) {
              print(
                  "save data locally >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${event.task.toJson()}");
              emit(AddTaskSuccessfully(event.task.id!));
            });
          } else {
            await backEnd.addTask(event.task);
            print(
                "add task successfully.......................${event.task.id}..");
            // event.task.id = taskID;
            // print("task id :::::: ${event.task.id}");
            // update task to firebase to add id
            // await backEnd.updateTask(event.task).then((value) {
            // emit(LoadingState());
            emit(AddTaskSuccessfully(event.task.id!));
            // });
          }
          // });
        }
      } catch (e) {
        emit(AddTaskFailure("something occure: ${e.toString()}"));
      }
    });
  }
}
