import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/providers/auth_provider.dart';



import '../../firebase_utils.dart';
import '../../model/task_model.dart';
import '../../my_theme.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedDate =DateTime.now();
  var formKey = GlobalKey<FormState>();
  var title = TextEditingController();
  var description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            local.new_task,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                      controller: title,
                      cursorColor: MyTheme.blueColor,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return local.task_title_error_message ;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.blueColor)),
                        hintText: local.task_title_label ,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: description,
                    cursorColor: MyTheme.blueColor,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return local.task_description_error_message ;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.labelLarge,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: MyTheme.blueColor)),
                      hintText: local.task_description_label ,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(local.date_label ,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      showCalender();
                    },
                    child: Text(
                      DateFormat.yMMMd().format(
                          selectedDate) /*'${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'*/,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: MyTheme.blueColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    child: Text(
                      local.add ,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MyTheme.whiteColor),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCalender() async {
    /* DateTime? chosenDate=DateTime.now();*/
    var chosenDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: MyTheme.blueColor)),
              child: child!);
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    selectedDate = chosenDate ?? selectedDate;

    setState(() {

    });

  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      var task = TaskModel(
          title: title.text,
          description: description.text,
          dateTime: DateUtils
              .dateOnly(selectedDate));
      var authProvider = Provider.of<AuthProvider>(context,listen: false);
      DialogUtils.showLoading(context, 'waiting...');
      FirebaseUtils.addTask(task,authProvider.currentUser?.id ?? '').
      then((value) async {
        DialogUtils.hideDialog(context);
        DialogUtils.showMessage(context, 'Task added successfully');
        await Future.delayed(const Duration(seconds: 3));
        DialogUtils.hideDialog(context);
        DialogUtils.hideDialog(context);
      },
      );


      /*timeout(
        Duration(milliseconds: 500),
        onTimeout: () {
          print('done');
          Navigator.pop(context);
        },
      );*/
    }
  }

}

