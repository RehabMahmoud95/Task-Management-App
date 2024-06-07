import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/models/taskModel.dart';
import 'package:intl/intl.dart';

class LocalDB {
  Future<void> saveTaskData(TaskModel task) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('title', task.title!);
    await prefs.setString('date', task.date.toString());
    await prefs.setBool('isDone', task.isDone!);
  }

  Future getTaskData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    TaskModel? task = TaskModel("", "", false);
    final String? title = await prefs.getString('title');
    if (title != null) {
      task.title = await prefs.getString('title');
      final String? date = await prefs.getString('date');
      // String dateWithT = date!.substring(0, 8) + 'T' + date.substring(8);
      // DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date!);

      // // DateTime dateTime = DateTime.parse(tempDate);
      // Timestamp timestamp = Timestamp.fromDate(tempDate);
      task.date = date;
      task.isDone = await prefs.getBool('isDone');
    }
    return task;
  }

  Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
