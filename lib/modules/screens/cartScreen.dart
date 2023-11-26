
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/navigation.dart';
import 'package:furniture_store/shared/icon_broken.dart';
import '../../components/cart_item.dart';
import '../../components/default_button.dart';
import '../../cubits/shop_cubit/shopCubit.dart';
import '../../cubits/shop_cubit/states.dart';
import 'select_address_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          int length = cubit.cartItems.length;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left_2,color: Colors.black,),
              ),
              title: const Text('Cart'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: cubit.cartItems.isNotEmpty
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 1,
                              childAspectRatio: 2.3,
                              // crossAxisSpacing: 0.1,
                              // mainAxisSpacing: 0.1,
                              children: List.generate(
                                  length,
                                  (index) => cartItem(
                                      data: cubit.cartItems[index],
                                      context: context,
                                      cubit: cubit,
                                      index: index
                                  )
                              ),
                            ))
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
                Material(
                  borderRadius: BorderRadius.circular(30),
                  elevation: 20,
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text('Total Price',style: TextStyle(
                                  color: Colors.blueGrey,
                                ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${cubit.totalPrice}',style: const TextStyle(
                                      fontSize: 20,
                                    ),),
                                    Text(' \$',style: TextStyle(fontSize: 20,color: Colors.green),),
                                  ],
                                )
                              ],
                            ),
                          ),
                          defaultButton(
                              onPressed: cubit.cartItems.isEmpty?null:(){
                                cubit.getCities().then((value){
                                  navigateTo(context: context, page: const SelectAddressScreen());
                                });
                              },
                              text: 'Purchase',
                            icon: const Icon(IconBroken.Buy,color: Colors.white,)
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
