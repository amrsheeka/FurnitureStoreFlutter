import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { ERROR, SUCCESS, WARNING }
void showToast({required String message, required ToastType type}) {
  Color? color;
  Color? textColor = Colors.white;
  if (type == ToastType.SUCCESS) {
    color = Colors.green;
  } else if (type == ToastType.WARNING) {
    color = Colors.yellow;
    textColor = Colors.black;
  }
  if (type == ToastType.ERROR) {
    color = Colors.red;
  }
  Fluttertoast.showToast(
      msg: message,
      textColor: textColor,
      backgroundColor: color,
      toastLength: Toast.LENGTH_LONG);
}