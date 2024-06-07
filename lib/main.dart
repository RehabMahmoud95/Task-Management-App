import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/bloc/add_task_bloc.dart';
// import 'package:task_management_app/bloc/check%20connectivity/bloc/connectivity_bloc.dart';
import 'package:task_management_app/bloc/delete_task_bloc.dart';
import 'package:task_management_app/bloc/get_all_tasks_bloc.dart';
import 'package:task_management_app/bloc/update_task_bloc.dart';
import 'package:task_management_app/constants.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:task_management_app/screens/desktopScreens/desktopScreen.dart';
import 'package:task_management_app/screens/mobileScreens/mobileHome.dart';
import 'package:task_management_app/screens/responsiveScreen.dart';
import 'package:task_management_app/services/backend.dart';
import 'package:task_management_app/services/connectivity.dart';
import 'package:task_management_app/services/localDB.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCAujulwvE2TdmOhyOImYp36UmmmP4QNcg',
    appId: '1:113283496942:android:cfdb8b10e637a626862cff',
    messagingSenderId: 'sendid',
    projectId: 'task-5c149',
    storageBucket: 'task-5c149.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LocalDB localDB = LocalDB();
  TaskModel? task;

  // @override
  // void initState() {
  //   checkConnectivity();
  //   super.initState();
  // }

  Future<ConnectivityResult> checkConnectivity() async {
    late StreamSubscription<ConnectivityResult> _connectivitySubscription;

    late ConnectivityResult result = ConnectivityResult.none;
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult _result) {
      print("connectivity result :::::::::::::::::::::::: ${_result.name}");
      //
      setState(() {
        result = _result;
      });
      if (_result.name != "none") {
        localDB.getTaskData().then((value) {
          print(
              "data is from local <<<<<<<<<<<<<<<<<<<<<< : ${value.title.toString()}");
          if (value.title.toString().isNotEmpty) {
            //add data to firestore
            BackEnd().addTask(value).then((value) {
              localDB.clearData();
            });
            // BlocProvider.of<AddTaskBloc>(context).add(AddTask(value));
          }
        });
      } else {
        // BlocProvider.of<GetAllTasksBloc>(context).add(GetAllTasks());
      }
    });
    return result;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    checkConnectivity();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetAllTasksBloc(BackEnd())..add(GetAllTasks()),
        ),
        BlocProvider(create: (context) => AddTaskBloc(BackEnd())),
        BlocProvider(create: (context) => DeleteTaskBloc(BackEnd())),
        BlocProvider(create: (context) => UpdateTaskBloc(BackEnd()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Constants.mainColor),
          useMaterial3: true,
        ),
        home: const ResponsiveScreen(MobileScreen(), DesktopScreen()),
      ),
    );
  }
}
