// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/bloc/delete_task_bloc.dart';
import 'package:task_management_app/bloc/get_all_tasks_bloc.dart';
import 'package:task_management_app/bloc/update_task_bloc.dart';
import 'package:task_management_app/constants.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:task_management_app/services/backend.dart';

class ConstantsWidget {
  static Widget tabTitle(String text, int index, int currentIndex) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 75,
        decoration: BoxDecoration(
            color: (currentIndex == index)
                ? Constants.mainColor
                : Constants.mainColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              text,
              style: TextStyle(
                  color: (currentIndex == index)
                      ? Colors.green[50]
                      : Constants.mainColor,
                  fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }

  static Widget MyErrorWidget(String error, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          error,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<GetAllTasksBloc>(context).add(GetAllTasks());
            },
            child: Text("Try Again"))
      ],
    );
  }
}
