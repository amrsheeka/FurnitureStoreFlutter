
import 'package:flutter/material.dart';

import '../cubits/shop_cubit/shopCubit.dart';
import '../models/productModel.dart';
import '../modules/screens/productScreen.dart';
import '../shared/constants.dart';
import '../shared/icon_broken.dart';
import 'navigation.dart';

Widget favoriteItem(
    {required ProductModel? data,
      required context,
      required ShopCubit cubit,
      required int index}) {
  return InkWell(
    onTap: () {
      navigateTo(context: context, page: ProductScreen(data!, index));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white,secondaryColor,]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('${data?.images[0]}'))),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 120,
                      child: Column(
                        children: [
                          Text(
                            '${data?.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Spacer(),
                          Text(
                            '${data?.price} \$',
                            style: TextStyle(color: mainColor, fontSize: 20),
                          ),
                          data!.oldPrice > data.price
                              ? Text(
                            '${data.oldPrice} \$',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          )
                              : Container(),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      data.oldPrice > data.price
                          ? Container(

                        decoration: const BoxDecoration(
                          color: mainColor,
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
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: CircleAvatar(
                        radius: 23,
                        backgroundColor: cubit.favorite[data.id] == true
                            ? mainColor
                            : Colors.grey[200],
                        child: IconButton(
                          icon: const Icon(
                            IconBroken.Heart,
                            size: 30,
                          ),
                          onPressed: () {
                            cubit.toggleFavorite(id: '${data.id}');
                          },
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}