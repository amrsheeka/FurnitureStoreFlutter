import 'package:flutter/material.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/shared/constants.dart';

import '../shared/icon_broken.dart';

Widget orderItem({required ShopCubit cubit,required int index})=>InkWell(
  onTap: () {
  },
  child: Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              const Icon(IconBroken.Location,color: Colors.blueGrey,),
              Expanded(
                  child: Text(
                    cubit.orders[index].address,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
              ),
            ],
          ),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => Column(
                        children: [
                          Container(
                            height: 70,
                            width: 80,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(cubit.orders[index].orderItems[i].image)
                                )
                            ),
                          ),
                          Text('${cubit.orders[index].orderItems[i].product.price} \$',style: TextStyle(
                            color: mainColor
                          ),),
                        ],
                      ),
                      separatorBuilder: (context, i) => SizedBox(width: 10,),
                      itemCount: cubit.orders[index].orderItems.length
                  ),
                ),
                //TextButton(onPressed: (){}, child: Text('See All'))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total:   ',style: TextStyle(color: Colors.blueGrey),),
              Text('${cubit.orders[index].totalAmount}',style: TextStyle(
                color: Colors.green[500]
              ),)
            ],
          ),
        ],
      ),
    ),
  ),
);