import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/screens/tasks/task_widget.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
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
          child: ListView.builder(itemBuilder: (context, index) => TaskWidget(),
          itemCount: 20,),
        )
      ],
    );
  }
}
