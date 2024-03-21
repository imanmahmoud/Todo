import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/*import 'package:cloud_firestore/cloud_firestore.dart';*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/screens/tasks/task_widget.dart';


import '../../firebase_utils.dart';
import '../../model/task_model.dart';
import '../../my_theme.dart';

class TaskList extends StatefulWidget {
  TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {
              selectedDate = date;
            });
          },
          leftMargin: 20,
          monthColor: Theme.of(context).colorScheme.onSecondary,
          dayColor: Theme.of(context).colorScheme.onSecondary,
          activeDayColor: Theme.of(context).colorScheme.secondary,
          activeBackgroundDayColor: MyTheme.blueColor,
          dotsColor: Theme.of(context).colorScheme.secondary,
          selectableDayPredicate: (date) => true,
          locale: 'en',
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: FirebaseUtils.getTasks(selectedDate,authProvider.currentUser?.id??''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                  // DialogUtils.showLoading(context, 'waiting...');
                }

                if (snapshot.hasError) {
                  /*return Center(child: Text('Something went wrong'));*/
                  DialogUtils.hideDialog(context);
                  DialogUtils.showMessage(context, snapshot.error.toString(),posActionName: 'ok');
                }


                var tasks =
                    snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

                return ListView.builder(
                  itemBuilder: (context, index)  {
                    /* DialogUtils.hideDialog(context);*/
                    return TaskWidget(tasks[index]);},
                  itemCount: tasks.length,
                );
              },
            )
          /*ListView.builder(
              itemBuilder: (context, index) => TaskWidget(TaskModel(title: 'title', description: 'description', dateTime: DateTime.now())),
              itemCount: 4,
            )*/
        )
      ],
    );
  }
}
