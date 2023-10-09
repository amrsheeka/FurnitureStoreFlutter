
import 'package:flutter/material.dart';

void navigateAndFinish({required context, required Widget page}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void navigateTo({required context, required Widget page}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}