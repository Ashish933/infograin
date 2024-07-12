import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:slice_ledger/src/utils/colors.dart';

import 'fonts.dart';

class MyDialogBox {
  static Future<void> progressDialogue() async {
    // Check if the navigatorKey and its currentState are not null
    if (navigatorKey.currentState == null) {
      return;
    }

    // Set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: LoadingAnimationWidget.discreteCircle(
          size: 30,
          color: AppColors.secondaryColor,
        ),
      ),
    );

    // Show the dialog
    return showDialog(
      // Prevent outside touch
      barrierDismissible: false,
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        // Prevent Back button press
        return WillPopScope(
          onWillPop: () async => false,
          child: alert,
        );
      },
    );
  }

  static void close() {
    navigatorKey.currentState!.pop();
  }
}
