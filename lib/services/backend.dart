import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_app/models/taskModel.dart';

class BackEnd {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> deleteTask(TaskModel task) async {
    final CollectionReference tasks = db.collection('tasks');
    // final newTask = task.toJson();
    tasks
        .doc(task.id)
        .delete()
        .then((value) => print("task deleted siccessfully"));
    // return task;
  }

  Future addTask(TaskModel task) async {
    final CollectionReference tasks = db.collection('tasks');

    final newTask = task.toJson();
    // tasks.doc().id;
    await tasks.doc(task.id).set(newTask);
    // print("value id ::::::::::::::::::::::: ${value.id}");
    // task.id!.replace(0, value.id);

    // tasks.doc(value.id).set(newTask).then((newVal) {
    //   print("new task : ${task.id}");
    // return value.id;
    // });
    // });
    // return "";
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    final CollectionReference tasks = db.collection('tasks');
    // print(
    //     "task::::::::::::::::::::::::::::::::: is : ${task.title}, task id: ${taskID}");
    final newTask = task.toJson();
    tasks
        .doc(task.id)
        .set(newTask)
        .then((value) => print("task updated successfully }"));
    return task;
  }

  Future<List<TaskModel>> getAllTasks() async {
    final CollectionReference tasks = db.collection('tasks');

    // List<QueryDocumentSnapshot>? allProducts;
    List<Map<String, dynamic>> allTask = [];
    List<TaskModel> myList = [];
    try {
      await tasks.get().then((value) {
        for (var task in value.docs) {
          allTask.add(task.data() as Map<String, dynamic>);
        }
        for (var myProduct in allTask) {
          myList.add(TaskModel.fromJson(myProduct));
        }
        print("all tasks :::::::::::::::::::: " + myList.toString());
      });
    } catch (e) {
      rethrow;
    }
    return myList;
    // print(
    //     "all products ::::::::::::::::::::: ${allProducts.docs.first.data()}");
    // return allProducts.docs.;
  }
}
