import 'package:flutter/material.dart';

Widget line({ String? inlineText,Icon? icon})=>Row(
  children: [
    Expanded(
      child: Container(
        height: 1,

        color: Colors.blueGrey[50],
      ),
    ),
    Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(inlineText??'',style: const TextStyle(fontSize: 10,color: Colors.blueGrey),),
        ),
        icon??Container()
      ],
    ),
    Expanded(
      child: Container(
        height: 1,

        color: Colors.blueGrey[50],
      ),
    ),

  ],
);