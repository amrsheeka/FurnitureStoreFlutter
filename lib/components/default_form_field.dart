
import 'package:flutter/material.dart';

import '../shared/constants.dart';

Widget defaultFormField(
    {onPressed,
      void Function(String)? onChanged,
      maxLines = 1,
      suffixIcon,
      prefixIcon,
      keyboardType,
      String? initialValue,
      obscureText = false,
      required String label,
      String? Function(String?)? validator,
      TextEditingController? controller}) =>
    TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor: mainColor,
        focusColor: mainColor,
        iconColor: mainColor,
        fillColor: Colors.blueGrey[50],
        filled: true,
        label: Text(label),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.white,
            //width: 2.0,
          ),
        ),
      ),
    );