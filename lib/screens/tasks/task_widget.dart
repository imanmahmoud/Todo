import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../my_theme.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyTheme.redColor,
      ),
      margin: EdgeInsets.all(size.width * 0.04),

      child: Slidable(

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),


          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft:Radius.circular(15) ),
              onPressed: (context) {

              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
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
                       borderRadius:
                          BorderRadius.circular(12),
                      color: MyTheme.blueColor)),
              SizedBox(width:size.width*0.05,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('task 1',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: MyTheme.blueColor)),
                    Text('describe 1',style: Theme.of(context).textTheme.labelSmall),
                    /*Text('25/6')*/],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).primaryColor,
                ),
                child: Icon(
                  Icons.check,
                  size: 35,
                  color: MyTheme.whiteColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
