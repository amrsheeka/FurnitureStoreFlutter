import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubits/shop_cubit/shopCubit.dart';
import '../models/productModel.dart';
import '../modules/screens/productScreen.dart';
import '../shared/constants.dart';
import 'navigation.dart';

Widget cartItem(
    {required ProductModel? data,
      required context,
      required ShopCubit cubit,
      required int index}) {
  int amount = cubit.cart[index].count;
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
                              image: NetworkImage(
                                  '${data?.images[cubit.cart[index].imageIndex]}'))),
                    ),
                    const SizedBox(
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
                            style:
                            const TextStyle(color: mainColor, fontSize: 20),
                          ),
                          data!.oldPrice > data.price
                              ? Text(
                            '${data.oldPrice} \$',
                            style: const TextStyle(
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
                SizedBox(
                  height: 130,
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: IconButton(
                        onPressed: () {
                          cubit.toggleCart(
                              index: index,
                              id: '${data.id}',
                              imageIndex: cubit.cart[index].imageIndex);
                        },
                        icon: const Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.red,
                        )),
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Padding(
                    padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Container(
                        height: 35,
                        width: 130,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cubit.cart[index].count == 1
                                ? IconButton(
                                onPressed: () {
                                  cubit.toggleCart(
                                      index: index,
                                      id: '${data.id}',
                                      imageIndex:
                                      cubit.cart[index].imageIndex);
                                },
                                icon:
                                const Icon(Icons.remove_shopping_cart))
                                : FloatingActionButton(
                              heroTag: 'minusCart$index',
                              onPressed: () {
                                amount--;
                                cubit.toggleCart(
                                    index: index,
                                    amount: amount,
                                    imageIndex:
                                    cubit.cart[index].imageIndex,
                                    id: '${data.id}',
                                    productIndex:
                                    cubit.cart[index].productIndex);
                              },
                              backgroundColor: Colors.grey[200],
                              elevation: 0,
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                            ),
                            Text('$amount'),
                            FloatingActionButton(
                              heroTag: 'plusCart$index',
                              onPressed: () {
                                amount++;
                                cubit.toggleCart(
                                    index: index,
                                    amount: amount,
                                    imageIndex: cubit.cart[index].imageIndex,
                                    id: '${data.id}',
                                    productIndex:
                                    cubit.cart[index].productIndex);
                              },
                              backgroundColor: Colors.grey[200],
                              elevation: 0,
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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