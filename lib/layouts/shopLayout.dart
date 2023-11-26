import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/modules/screens/cartScreen.dart';
import 'package:furniture_store/modules/screens/loginScreen.dart';
import 'package:furniture_store/shared/icon_broken.dart';

import '../components/navigation.dart';
import '../cubits/shop_cubit/shopCubit.dart';
import '../cubits/shop_cubit/states.dart';
import '../shared/constants.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: cubit.currentIndex!=cubit.screens.length-1?AppBar(
              backgroundColor: Colors.white,
              title: Text(cubit.appBarTitle[cubit.currentIndex]),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context: context, page: const CartScreen());
                    },
                    icon: const Icon(
                      IconBroken.Bag,
                      color: mainColor,
                    )),
                IconButton(
                    onPressed: () {
                      cubit.logOut().then((value){
                        navigateAndFinish(context: context, page: const LoginScreen());
                      });
                    },
                    icon: const Icon(
                      IconBroken.Logout,
                      color: Colors.red,
                    ))
              ],
            ):null,
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              fixedColor: mainColor,
              unselectedIconTheme: const IconThemeData(
                color: Colors.blueGrey
              ),
              landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
              type: BottomNavigationBarType.shifting,
              unselectedItemColor: Colors.grey,

              onTap: (index) {
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Heart), label: 'Favourites'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Buy), label: 'Orders'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.User), label: 'Profile'),
              ],
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }
}
