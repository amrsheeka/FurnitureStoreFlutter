import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/modules/screens/searchScreen.dart';
import 'package:furniture_store/shared/icon_broken.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../components/categories_item.dart';
import '../../components/home_item.dart';
import '../../components/navigation.dart';
import '../../cubits/shop_cubit/shopCubit.dart';
import '../../cubits/shop_cubit/states.dart';

import '../../shared/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          int length = cubit.products.length;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) =>     Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: InkWell(
                                onTap: (){
                                  navigateTo(context: context, page: SearchScreen());
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.symmetric(horizontal: 30),
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      borderRadius: BorderRadius.circular(20)

                                  ),
                                  child: Row(
                                    children: [
                                      Icon(IconBroken.Search,color: Colors.grey,),
                                      SizedBox(width: 10,),
                                      Text('Search',style: TextStyle(color: Colors.grey),)
                                    ],
                                  ),
                                )
                            ),
                          ),
                      childCount: 1
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400.0,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 5.5,
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) => ConditionalBuilder(
                              condition: cubit.slider.isNotEmpty,
                              builder: (context)=>Stack(
                                children: [
                                  CarouselSlider(
                                      items: cubit.slider
                                          .map((e) => Image(
                                          centerSlice: Rect.largest,
                                          image: NetworkImage('$e')))
                                          .toList(),
                                      options: CarouselOptions(
                                        onPageChanged: (index,reason){
                                          cubit.changeSliderIndex(index);
                                        },
                                        autoPlay: true,
                                        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                        reverse: false,
                                        initialPage: cubit.sliderIndex,
                                        autoPlayInterval: Duration(seconds: 2),
                                        viewportFraction: 1.0,
                                        aspectRatio: 1.9,
                                        enableInfiniteScroll: true,
                                        autoPlayAnimationDuration: Duration(seconds: 1),
                                      )),
                                  SizedBox(
                                    height: 200,
                                    child: Align(
                                      alignment: AlignmentDirectional.bottomCenter,
                                      child: AnimatedSmoothIndicator(
                                        effect: ExpandingDotsEffect(
                                            dotHeight: 10,
                                            dotWidth: 10,
                                            activeDotColor: mainColor),


                                        count: cubit.slider.length,
                                        activeIndex: cubit.sliderIndex,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              fallback: (context)=>const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: CircularProgressIndicator(),
                              )
                          ),
                      childCount: 1
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400.0,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1.8,
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 40.0,
                  title: SizedBox(
                    height: 40,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => categoriesItem(cubit: cubit, index: index,name: cubit.categories[index]),
                        separatorBuilder: (context, index) => const SizedBox(width: 10,),
                        itemCount: cubit.categories.length
                    ),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => homeItem(
                        data: cubit.products[index],
                        context: context,
                        cubit: cubit,
                        index: index),
                    childCount: length
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 0.8,
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
