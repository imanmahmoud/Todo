import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/my_theme.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedDate=DateTime.now();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            local.new_task,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key:formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                     validator: (text) {
                       if(text==null || text.trim().isEmpty){
                         return local.task_title_error_message;
                       }
                       return null;
                     },
                      decoration: InputDecoration(hintStyle: Theme.of(context).textTheme.labelLarge,
                        hintText: local.task_title_label,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (text) {
                      if(text==null || text.trim().isEmpty){
                        return local.task_description_error_message;
                      }
                      return null;
                    },
                    decoration: InputDecoration(hintStyle: Theme.of(context).textTheme.labelLarge,
                      hintText: local.task_description_label,
                    ),
                    style:  Theme.of(context).textTheme.bodyMedium,

                    maxLines: 4,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(local.date_label,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      showCalender();
                    },
                    child: Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    child: Text(
                      local.add,
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
   var chosenDate=await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );

   setState(() {
     selectedDate=chosenDate ?? selectedDate;
   });
  }

  void addTask() {
    if(formKey.currentState?.validate()==true){

    }
  }
}


