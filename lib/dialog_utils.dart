import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
              children: [CircularProgressIndicator(),
                SizedBox(width: 12),
                Text(message,)]),
        );
      },
    );
  }

  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context,String message,
      { String title = "" ,
        String? posActionName,
        VoidCallback? posAction,
        String? negActionName,
        VoidCallback? negAction,
        bool isDismissible=false
      }){
    List<Widget> actions=[];
    if(posActionName != null){
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        posAction?.call();
      },
          child: Text(posActionName)));
    }
    if(negActionName != null){
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        negAction?.call();
      },
          child: Text(negActionName)));
    }

    showDialog(
      barrierDismissible: isDismissible,
      context: context, builder: (context) {
      return AlertDialog(
        title:Text(title) ,
        content: Text(message,style: TextStyle(fontWeight: FontWeight.w400),/*textAlign: TextAlign.center*//*style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight:FontWeight.w200)*/),
        actions: actions,
        /*titleTextStyle: Theme.of(context).textTheme.titleMedium,*/
        /*contentTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight:FontWeight.w400),*/
      );
    },);
  }
}
