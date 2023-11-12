
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/favorite_item.dart';
import '../../cubits/shop_cubit/shopCubit.dart';
import '../../cubits/shop_cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          int length = cubit.favoriteItems.length;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: cubit.favoriteItems.isNotEmpty?SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:
                   GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      childAspectRatio: 2.3,
                      // crossAxisSpacing: 0.1,
                      // mainAxisSpacing: 0.1,
                      children: List.generate(
                          length,
                          (index) => favoriteItem(
                              data: cubit.favoriteItems[index],
                              context: context,
                              cubit: cubit,
                              index: index)),
                    )

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
                  Text('No saved product yet...!',style: TextStyle(color: Colors.grey[400])),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
