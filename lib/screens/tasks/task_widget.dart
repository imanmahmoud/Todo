import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/dialog_utils.dart';
/*import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/firebase_utils.dart';*/
import 'package:todo/model/task_model.dart';
import 'package:todo/providers/auth_provider.dart';

import '../../firebase_utils.dart';
import '../../my_theme.dart';
import 'edit_task.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  const TaskWidget(this.task, {super.key});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EditTask.routeName, arguments: task);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyTheme.redColor,
        ),
        margin: EdgeInsets.all(size.width * 0.04),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                onPressed: (context) {
                  FirebaseUtils.deleteTask(
                      task, authProvider.currentUser?.id ?? "")
                      .then((value) async {
                    DialogUtils.showMessage(context, 'Deleted successfully');
                    await Future.delayed(const Duration(seconds: 2));
                    // ignore: use_build_context_synchronously
                    DialogUtils.hideDialog(context);
                  }).catchError((error) => DialogUtils.showMessage(
                      context, error.toString(),
                      posActionName: 'ok'));
                  /*timeout(
                    Duration(milliseconds: 500),
                    onTimeout: () {
                      print('deleted');
                      print(task.id);

                    },
                  );*/
                },
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
                label: /*AppLocalizations.of(context)!.delete*/ 'Delete',
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor,
            ),
            padding: EdgeInsets.all(size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*VerticalDivider(indent: 20,endIndent: 20,thickness: 4,color: MyTheme.blueColor),*/
                Container(
                    height: size.height * 0.08,
                    width: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: task.isDone!
                            ? MyTheme.greenColor
                            : MyTheme.blueColor)),
                SizedBox(
                  width: size.width * 0.05,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: task.isDone!
                              ? MyTheme.greenColor
                              : MyTheme.blueColor)),
                      Text(task.description ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall), /*Text('25/6')*/
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    task.isDone = !task.isDone!;
                    FirebaseUtils.updateTask(
                        task/*.id ?? ''*/,
                        /*task.isDone! ,*/
                        authProvider.currentUser?.id ?? "");
                  },
                  child: task.isDone!
                      ? Text('Done!',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                          color: MyTheme.greenColor, fontSize: 22))
                      : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 35,
                      color: MyTheme.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
