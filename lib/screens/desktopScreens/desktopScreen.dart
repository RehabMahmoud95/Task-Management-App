import 'package:flutter/material.dart';
import 'package:task_management_app/constants.dart';
import 'package:task_management_app/widgets/constantsWidget.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Good Morning",
          style: Constants.titleStyle,
        ),
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
          // TasksScreen(),
          SizedBox(height: 30),
          ContainerBtn("Add Task", context)
        ],
      ),
    );
  }
Widget ContainerBtn(String text, BuildContext context) {
    
    return InkWell(
      onTap: () {
        if (text == "Add Task") {
          
        } else if (text == "Save Task") {
          // add task to firebase
         
        }
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
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }

}
