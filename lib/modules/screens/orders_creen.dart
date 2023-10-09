import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/cubits/shop_cubit/states.dart';
import '../../components/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          int length = cubit.orders.length;
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: cubit.orders.isNotEmpty
                      ? GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: 2.1,
                        // crossAxisSpacing: 0.1,
                        // mainAxisSpacing: 0.1,
                        children: List.generate(
                            length,
                                (index) => orderItem(cubit: cubit, index: index)
                        ),
                      )
                      : Align(
                    alignment: AlignmentDirectional.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.not_interested,
                          size: 100,
                          color: Colors.grey[300],
                        ),
                        Text('No saved product yet...!',
                            style: TextStyle(color: Colors.grey[400])),
                      ],
                    ),
                  ),

                ),
              ),

            ],
          );
        },
        listener: (context, state) {

        },
    );
  }
}
