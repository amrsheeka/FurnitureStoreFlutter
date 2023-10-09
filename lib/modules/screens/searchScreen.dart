import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/cubits/shop_cubit/states.dart';

import '../../components/categories_item.dart';
import '../../components/default_form_field.dart';
import '../../components/home_item.dart';
import '../../shared/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var query = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        int length = cubit.searchResults.length;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: defaultFormField(
              onChanged: (value){
                cubit.searchQuery=value;
                cubit.search(query: value);
              },
                label: 'Enter the product name',
                controller: query,
                prefixIcon: const Icon(IconBroken.Search)
            ),
            leading: IconButton(
              onPressed: () {
                cubit.searchQuery='';
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  titleSpacing: -50,
                  expandedHeight: 40.0,
                  title: SizedBox(
                    height: 40,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => categoriesItem(cubit: cubit, index: index,name: cubit.categories[index]),
                        separatorBuilder: (context, index) => SizedBox(width: 10,),
                        itemCount: cubit.categories.length
                    ),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) => homeItem(
                          data: cubit.searchResults[index],
                          context: context,
                          cubit: cubit,
                          index: index),
                      childCount: length
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: .9,
                  ),
                ),

              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}
