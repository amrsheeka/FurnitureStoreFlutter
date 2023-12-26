
import 'package:flutter/material.dart';

Widget onBoardingItem(
    {required String? title,
      required String? body,
      required String? picture}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
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
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text('$title',
                          style: const TextStyle(fontSize: 25),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('$body',
                          style: const TextStyle(
                              fontSize: 18, height: 1, color: Colors.blueGrey),
                          maxLines: 10,
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