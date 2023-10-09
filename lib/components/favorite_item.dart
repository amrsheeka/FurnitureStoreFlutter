
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
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        //set border radius more than 50% of height and width to make circle
      ),
      child: SizedBox(
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
                Container(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      data.oldPrice > data.price
                          ? Container(
                        color: Colors.green,
                        padding: EdgeInsetsDirectional.all(2.0),
                        child: Text(
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
                        backgroundColor: cubit.favorite['${data.id}'] == true
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
                Container(
                  height: 130,
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
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