import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/bloc/delete_task_bloc.dart' as delete;
import 'package:task_management_app/bloc/get_all_tasks_bloc.dart';
import 'package:task_management_app/bloc/update_task_bloc.dart' as update;
import 'package:task_management_app/constants.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:task_management_app/widgets/constantsWidget.dart';

class TasksScreen extends StatefulWidget {
  final int currentIndex;
  const TasksScreen(this.currentIndex, {super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // List<TaskModel> tasks = [
  //   TaskModel("Build ui android", "", true),
  //   TaskModel("Build ui android", "", true),
  //   TaskModel("Build ui android", "", false),
  //   TaskModel("Build ui android", "", true),
  //   TaskModel("Build ui android", "", false),
  //   TaskModel("Build ui android", "", false),
  //   TaskModel("Build ui android", "", true),
  // ];
  List<TaskModel> doneTasks = [];
  List<TaskModel> notDoneTasks = [];
  List<TaskModel> allTasks = [];
  String _direction = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height - 250),
      height: MediaQuery.of(context).size.height - 250,
      child: BlocBuilder<GetAllTasksBloc, GetAllTasksState>(
        builder: (context, state) {
          if (state is OfflineState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<GetAllTasksBloc>(context)
                          .add(GetAllTasks());
                    },
                    child: Text(
                      "Try Again",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 206, 51, 51)),
                    ))
              ],
            ));
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedState) {
            for (TaskModel task in state.tasks) {
              if (widget.currentIndex == 1 &&
                  !task.isDone! &&
                  !notDoneTasks.contains(task)) {
                notDoneTasks.add(task);
                // notDoneTasks.forEach((element) {
                //   print("element id: ${element.id}");
                //   if (element.id != task.id) {

                //   }
                // });
                //
                // for (int i = 0; i < doneTasks.length;i++) {
                //   print("Done tasks : ${doneTasks.toString()}");
                //   if (!doneTasks.contains(task)) {
                //   }
                // }

                // });
              } else if (widget.currentIndex == 2 &&
                  task.isDone! &&
                  !doneTasks.contains(task)) {
                doneTasks.add(task);
              }
            }
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: getTasks(state.tasks));
          } else if (state is ErrorState) {
            return ConstantsWidget.MyErrorWidget(state.message, context);
          }
          return Container();
        },
      ),
    );
  }

  Widget getTasks(List<TaskModel> tasks) {
    return ListView.builder(
      itemCount: (widget.currentIndex == 0)
          ? tasks.length
          : (widget.currentIndex == 1)
              ? notDoneTasks.length
              : doneTasks.length,
      itemBuilder: (context, index) {
        return taskWidget(
            (widget.currentIndex == 0)
                ? tasks[index]
                : (widget.currentIndex == 2)
                    ? doneTasks[index]
                    : notDoneTasks[index],
            context);
      },
    );
  }

  Widget taskWidget(TaskModel task, BuildContext context) {
    // DismissDirection direction = DismissDirection.none;
    return Dismissible(
      key: ValueKey<String>(task.id!),
      direction: DismissDirection.endToStart,
      onUpdate: (d) {
        // print("direction details : ${d.direction.name}");
        setState(() {
          _direction = d.direction.name;
        });
      },
      background: Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          color: Colors.green,
          child: Text(
            "Delete Task",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
      onDismissed: (direction) {
        print("direction <<<<<<<<<<<<<<<<<<<<<<<" + direction.name);
        if (direction.name == "endToStart") {
          BlocProvider.of<delete.DeleteTaskBloc>(context)
              .add(delete.DeleteTask(task: task));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text(
                task.title!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text("Due Date: ${task.date}"),
              trailing: doneContainer(task),
            ),
          ),
        ),
      ),
    );
  }

  Widget doneContainer(TaskModel task) {
    return InkWell(
      onTap: () {
        setState(() {
          task.isDone = !task.isDone!;
        });
        BlocProvider.of<update.UpdateTaskBloc>(context)
            .add(update.UpdateTask(task));

        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,

          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Great!',
            message: 'Task updated successfully',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      },
      child: Container(
        height: 25,
        width: 20,
        decoration: BoxDecoration(
          color: (task.isDone!)
              ? Constants.secondColor.withOpacity(0.2)
              : Constants.secondColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 5),
          child: Icon(
            size: 20,
            Icons.done,
            color: (task.isDone!)
                ? Constants.mainColor.withOpacity(0.5)
                : Constants.mainColor.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
