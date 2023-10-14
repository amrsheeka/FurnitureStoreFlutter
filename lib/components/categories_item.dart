import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubits/shop_cubit/shopCubit.dart';
import '../shared/constants.dart';

Widget categoriesItem({required ShopCubit cubit, required index,required String name}) {
  return InkWell(
    onTap: () {
      cubit.changeCategory(index: index,name: name);
    },
    child: Container(
      height: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(20),
          color:
          cubit.selectedCategory == index ? mainColor : Colors.blueGrey[50]),
      child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color:
                  cubit.selectedCategory == index ? Colors.white : Colors.black),
            ),
          )),
    ),
  );
}