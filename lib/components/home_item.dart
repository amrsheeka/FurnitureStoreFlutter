import 'package:flutter/material.dart';

import '../cubits/shop_cubit/shopCubit.dart';
import '../models/productModel.dart';
import '../modules/screens/productScreen.dart';

import '../shared/constants.dart';
import '../shared/icon_broken.dart';
import 'navigation.dart';

Widget homeItem(
    {required ProductModel? data,
      required context,
      required ShopCubit cubit,
      required int index}) {
  return InkWell(
    onTap: () {
      cubit.getReviews(productId: data!.id).then((value) {
        navigateTo(context: context, page: ProductScreen(data, index));
      });
    },
    child: Padding(
      padding: const EdgeInsetsDirectional.only(start: 8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white
                  ,Colors.white,Colors.white,
                  secondaryColor
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('${data?.images[0]}'))),
                ),
                SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      data!.oldPrice > data.price
                          ? Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          gradient: LinearGradient(
                            colors: [Colors.red, mainColor],
                          ),
                        ),

                        padding: const EdgeInsetsDirectional.all(2.0),
                        child: const Text(
                          'Discount',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ),
                //
              ],
            ),
            Text(
              data.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      '${data.price} \$',
                      style: const TextStyle(color: mainColor),
                    ),
                    data.oldPrice > data.price
                        ? Text(
                      '${data.oldPrice} \$',
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey),
                    )
                        : Container(),
                  ],
                ),
                const Spacer(),
                CircleAvatar(
                    radius: 23,
                    backgroundColor: cubit.favorite[data.id] == true
                        ? mainColor
                        : Colors.blueGrey[50],
                    child: IconButton(
                      icon: const Icon(
                        IconBroken.Heart,
                        size: 30,
                      ),
                      onPressed: () {
                        cubit.toggleFavorite(id: data.id);
                      },
                    )),
              ],
            ),
            //SizedBox(height: 10,),
          ],
        ),
      ),
    ),
  );
}