import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget onBoardingItem(
    {required String? title,
      required String? body,
      required String? picture}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('$picture'),
                )),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text('$title',
                          style: TextStyle(fontSize: 30),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(
                        height: 20,
                      ),
                      Text('$body',
                          style: TextStyle(
                              fontSize: 20, height: 1, color: Colors.blueGrey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );