import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/bloc/add_task_bloc.dart';
import 'package:task_management_app/bloc/get_all_tasks_bloc.dart';
import 'package:task_management_app/constants.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:task_management_app/screens/mobileScreens/tasks.dart';
import 'package:task_management_app/services/backend.dart';
import 'package:task_management_app/services/localDB.dart';
import 'package:task_management_app/widgets/constantsWidget.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  // with SingleTickerProviderStateMixin {
  // TabController? tabController;
  int currentIndex = 0;
  // ConnectivityResult? result;
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  TaskModel task = TaskModel("", "", false);
  BackEnd backend = BackEnd();
  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  DateTime? dateTime;
  LocalDB localDB = LocalDB();
  Random taskID = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<GetAllTasksBloc>(context).add(GetAllTasks());
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.green,
              ))
        ],
        title: Text(
          "Good Morning",
          style: Constants.titleStyle,
        ),

        // bottom: TabBar(
        //   padding: EdgeInsets.zero,
        //   indicatorPadding: EdgeInsets.zero,
        //   // labelPadding: EdgeInsets.zero,
        //   indicatorWeight: 3,
        //   // isScrollable: true,
        //   // padding: EdgeInsets.all(0),
        //   onTap: (index) {
        //     print("current index ${index}");
        //     setState(() {
        //       currentIndex = index;
        //     });
        //   },
        //   // labelColor: Colors.white,
        //   // indicatorWeight: 0,
        //   // indicatorPadding: EdgeInsets.all(10),
        //   indicatorColor: Constants.mainColor,
        //   unselectedLabelColor: Constants.secondColor,
        //   labelStyle: TextStyle(color: Colors.green[50]),
        //   dividerColor: (Colors.white),
        //   controller: tabController,
        //   tabs: [
        //     Tab(child: tabTitle("All", 0)
        //         // text: "All",
        //         ),
        //     Tab(child: tabTitle("Not Done", 1)
        //         // text: "Not Done",
        //         ),
        //     Tab(child: tabTitle("Done", 2)
        //         // text: "Done",
        //         ),
        //   ],
        // ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    child:
                        ConstantsWidget.tabTitle("All Tasks", 0, currentIndex)),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child:
                        ConstantsWidget.tabTitle("Not Done", 1, currentIndex)),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                    child: ConstantsWidget.tabTitle("Done", 2, currentIndex)),
                SizedBox(
                  width: 5,
                ),
              ],
            ),

            // child: TabBarView(
            //   controller: tabController,
            //   children: [TasksScreen(), TasksScreen(), TasksScreen()],
            // ),
          ),
          SizedBox(
            width: 10,
          ),
          TasksScreen(currentIndex),
          SizedBox(height: 30),
          BlocProvider<AddTaskBloc>(
            create: (context) => AddTaskBloc(BackEnd()),
            child: ContainerBtn("Add Task", context),
          )
        ],
      ),
    );
  }

  textFormField(String hint, TextEditingController controller) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "this field is required";
          } else if (value.length < 5) {
            return "${controller.text} is very short";
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
            fillColor: Colors.grey[50],
            filled: true,
            border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  showAddTaskForm(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      elevation: 2,

      // barrierColor: Colors.white,
      backgroundColor: Colors.white,
      // useSafeArea: true,
      // sheetAnimationStyle: _animationStyle,
      builder: (BuildContext context) {
        return Container(
          // padding: EdgeInsets.only(right: 20, left: 20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(20), left: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox.square(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Create New Task',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            textFormField("Task Title ", title),
                            SizedBox(
                              height: 20,
                            ),
                            // textFormField("Due Date ", date),
                            InkWell(
                              onTap: () async {
                                dateTime = await showOmniDateTimePicker(
                                        context: context)
                                    .whenComplete(() {})
                                    .then((v) {
                                  print("current date : ${v}");
                                  setState(() {
                                    dateTime = v;
                                  });
                                  return dateTime;
                                });
                              },
                              child: Material(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                                elevation: 1,
                                child: Container(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 15),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: dateTimeText()),
                                    )),
                              ),
                            ),
                            // DateTime? dateTime = await showOmniDateTimePicker(context: context);
                            SizedBox(
                              height: 20,
                            ),
                            ContainerBtn("Save Task", context),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget ContainerBtn(String text, BuildContext context) {
    return BlocBuilder<AddTaskBloc, AddTaskState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (text == "Add Task") {
              showAddTaskForm(context);
            } else if (text == "Save Task") {
              if (dateTime == null) {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'On Snap!',
                    message: 'Date can not be empty',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else if (_formKey.currentState!.validate() &&
                  dateTime != null) {
                setState(() {
                  task.id = taskID.nextInt(1000).toString() + "${title.text}";
                  task.date = dateTime!.year.toString() +
                      "/" +
                      dateTime!.month.toString() +
                      "/" +
                      dateTime!.day.toString();
                  task.title = title.text;
                  task.isDone = false;
                });
                BlocProvider.of<AddTaskBloc>(context).add(AddTask(task));
                setState(() {
                  dateTime = null;
                  title.clear();
                });
                Navigator.of(context).pop();
              }
              //  BlocProvider.of<GetAllTasksBloc>(context).add(GetAllTasks());
              //   _connectivitySubscription = Connectivity()
              //       .onConnectivityChanged
              //       .listen((ConnectivityResult _result) {
              //     print(
              //         "connectivity result :::::::::::::::::::::::: ${_result.name}");

              //  if(_result.name == "none"){

              //  }
              //     setState(() {
              //       result = _result;
              //     });
              //   });

              // context.read()<AddTaskBloc>().add(AddTask(task: task));
            }

            //   // if (result.name == "none") {
            //   //   localDB.saveTaskData(task);
            //   // } else {
            //   //   print(
            //   //       "result of connectivity :::::::::::::::::::::: ${result.name}");
            //   //   BlocProvider.of<AddTaskBloc>(context)
            //   //       .add(AddTask(task: task));
            //   // }
            //
            // }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
                color: Constants.mainColor,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }

  Text dateTimeText() {
    return Text(
      (dateTime != null)
          ? "${dateTime!.day} /${dateTime!.month} /${dateTime!.year}"
          : "Date Due",
      style: TextStyle(color: Colors.grey),
    );
  }
  // Future dateTime() async {
  //   DateTime? dateTime = await showOmniDateTimePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
  //     lastDate: DateTime.now().add(
  //       const Duration(days: 3652),
  //     ),
  //     is24HourMode: false,
  //     isShowSeconds: false,
  //     minutesInterval: 1,
  //     secondsInterval: 1,
  //     borderRadius: const BorderRadius.all(Radius.circular(16)),
  //     constraints: const BoxConstraints(
  //       maxWidth: 350,
  //       maxHeight: 650,
  //     ),
  //     transitionBuilder: (context, anim1, anim2, child) {
  //       return FadeTransition(
  //         opacity: anim1.drive(
  //           Tween(
  //             begin: 0,
  //             end: 1,
  //           ),
  //         ),
  //         child: child,
  //       );
  //     },
  //     transitionDuration: const Duration(milliseconds: 200),
  //     barrierDismissible: true,
  //     selectableDayPredicate: (dateTime) {
  //       // Disable 25th Feb 2023
  //       if (dateTime == DateTime(2023, 2, 25)) {
  //         return false;
  //       } else {
  //         return true;
  //       }
  //     },
  //   );
  // }
}
