import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/my_theme.dart';

class EditTask extends StatelessWidget {
  static const String routeName='EditTask';
   EditTask({super.key});
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var args =ModalRoute.of(context)?.settings.arguments as TaskModel;
    var selectedDate =args.dateTime;
    var title = TextEditingController(text: args.title);
    var description = TextEditingController(text: args.description);
    return Scaffold(
      appBar: AppBar(title: Text(local.app_title)),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height *0.7,
          width:MediaQuery.of(context).size.width *0.8 ,
         /* margin: EdgeInsets.symmetric(vertical:50 ,horizontal:30 ),*/
          decoration: /*ShapeDecoration(color: MyTheme.whiteColor,shape:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))) )*/
          BoxDecoration(
            color: MyTheme.whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              /*mainAxisSize: MainAxisSize.min,*/
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
                        child: TextFormField(/*expands:true ,*/
                            controller: title,
                            cursorColor: MyTheme.blueColor,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return local.task_title_error_message;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context).textTheme.labelLarge,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: MyTheme.blueColor)),
                              hintText: local.task_title_label,
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
                              return local.task_description_error_message;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.labelLarge,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: MyTheme.blueColor)),
                            hintText: local.task_description_label,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(local.date_label,textAlign:TextAlign.start ,
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            /*showCalender();*/
                          },
                          child: Text(
                            DateFormat.yMMMd().format(
                                selectedDate!) /*'${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'*/,
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
                            args=TaskModel(title: title.text, description: description.text, dateTime: DateUtils
                                .dateOnly(selectedDate));
                            FirebaseUtils.updateTask(args);
                            Navigator.pop(context);

                          },
                          child: Text(
                            local.save_changes,
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
          ),
        ),
      ),
    );
  }
}
