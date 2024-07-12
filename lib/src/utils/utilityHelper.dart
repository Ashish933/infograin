import 'package:flutter/material.dart';

import 'fonts.dart';

class UtilityHelper {
  static bool statusToast = true;

  static toastMessage(message) {
    if (message != null && message != "") {
      SnackBar snackBar = SnackBar(
          elevation: 7.0,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1500),
          backgroundColor: Colors.black,
          content: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              )));
      if (statusToast) {
        statusToast = false;
        scaffoldMessengerKey!.currentState?.showSnackBar(snackBar);
      }
      Future.delayed(const Duration(milliseconds: 1500), () {
        statusToast = true;
      });
    }
  }
}