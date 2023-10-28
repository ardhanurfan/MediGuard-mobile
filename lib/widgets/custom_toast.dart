import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mediguard/shared/theme.dart';

class CustomToast {
  static void showSuccess({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: greenColor.withOpacity(0.95),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showFailed({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: redColor.withOpacity(0.95),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
