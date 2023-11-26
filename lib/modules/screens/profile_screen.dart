
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/navigation.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/cubits/shop_cubit/states.dart';
import 'package:furniture_store/modules/screens/change_password_screen.dart';
import 'package:furniture_store/modules/screens/edit_address_screen.dart';
import 'package:furniture_store/modules/screens/loginScreen.dart';
import 'package:furniture_store/shared/constants.dart';
import 'package:furniture_store/shared/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopState>(
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 180.0,
                flexibleSpace: Container(
                  decoration:  const BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.purple, mainColor, Colors.purple],
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('${cubit.user?.name}',
                    ),
                  ),
                ),
              ),
              SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){
                          navigateTo(context: context, page: const EditAddressScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [Colors.white,secondaryColor]
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                const Text('Address',style: TextStyle(fontSize: 18,color: mainColor),),
                                const Spacer(),
                                Icon(IconBroken.Location,color: Colors.yellow[800],)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    childCount: 1
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 450.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 5.5,
                  ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [Colors.white,secondaryColor]
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text('Orders History',style: TextStyle(fontSize: 18,color: mainColor),),
                                Spacer(),
                                Icon(IconBroken.Buy,color: Colors.deepOrangeAccent,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    childCount: 1
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 5.5,
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){
                          navigateTo(context: context, page: const ChangePasswordScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [Colors.white,secondaryColor]
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text('Change Password',style: TextStyle(fontSize: 18,color: mainColor),),
                                Spacer(),
                                Icon(IconBroken.Password,color: Colors.deepOrangeAccent,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    childCount: 1
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 5.5,
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [Colors.white,secondaryColor]
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text('About Us',style: TextStyle(fontSize: 18,color: mainColor),),
                                Spacer(),
                                Icon(IconBroken.Info_Square,color: Colors.deepOrangeAccent,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    childCount: 1
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 5.5,
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: (){
                          cubit.logOut().then((value){
                            navigateAndFinish(context: context, page: const LoginScreen());
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [Colors.white,secondaryColor]
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text('Log Out',style: TextStyle(fontSize: 18,color: mainColor),),
                                Spacer(),
                                Icon(IconBroken.Logout,color: Colors.red,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    childCount: 1
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 5.5,
                ),
              ),
            ],
          );
        },
    );
  }
}
