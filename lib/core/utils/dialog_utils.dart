import 'package:flutter/material.dart';

import 'app_styles.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  style: AppStyles.medium14Header,
                ), // Text
              ) // Padding
            ],
          ), // Row
        ); // AlertDialog
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
        required String message,
        String? title,
        String? posActionName,
        Function? posAction,
        String? negActionName,
        Function? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(

        onPressed: () {
          Navigator.pop(context);
          posAction?.call();
        },
        child: Text(posActionName ,style: AppStyles.medium14Header,),
      ));
    }
    if (negActionName != null) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          negAction?.call();
        },
        child: Text(negActionName,style: AppStyles.medium14Header,),
      ));
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ??'',style: AppStyles.medium14Header,),
          content: Text(message,style: AppStyles.medium14Header,),
          actions: actions,
        );
      },
    );
  }
}