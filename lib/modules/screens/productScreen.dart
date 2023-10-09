import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture_store/components/show_%20rating_alert.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/cubits/shop_cubit/states.dart';
import 'package:furniture_store/models/productModel.dart';
import 'package:furniture_store/shared/icon_broken.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../components/default_button.dart';
import '../../components/default_form_field.dart';
import '../../shared/constants.dart';

class ProductScreen extends StatefulWidget {
  ProductModel product;
  int index;
  ProductScreen(this.product, this.index, {Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int selected = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 275,
                          width: double.infinity,
                          child: PageView.builder(
                              onPageChanged: (index) {
                                setState(() {
                                  selected = index;
                                });
                              },
                              physics: const BouncingScrollPhysics(),
                              controller: pageController,
                              itemCount: widget.product.images.length,
                              itemBuilder: (context, index) => SizedBox(
                                    height: 100,
                                    child: Image(
                                        image: NetworkImage(
                                            '${widget.product.images[index]}')),
                                  )),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: SmoothPageIndicator(
                                  effect: const ExpandingDotsEffect(
                                      dotHeight: 10,
                                      dotWidth: 10,
                                      activeDotColor: mainColor),
                                  controller: pageController,
                                  count: widget.product.images.length,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(widget.product.name,
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  CircleAvatar(
                                      radius: 23,
                                      backgroundColor: cubit.favorite[
                                                  widget.product.id] ==
                                              true
                                          ? mainColor
                                          : Colors.grey[200],
                                      child: IconButton(
                                        icon: const Icon(
                                          IconBroken.Heart,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          cubit.toggleFavorite(
                                              id: widget.product.id);
                                        },
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.product.description,
                                      style: const TextStyle(
                                          color: mainColor,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cubit.getMyProductReview(productId: widget.product.id).then((value){
                                          showRatingAlertDialog(
                                              context: context,
                                              product: widget.product,
                                              cubit: cubit
                                          );
                                        });
                                      },

                                      icon: const Icon(Icons.star,size: 30,color: Colors.amber,)),
                                  Text(
                                    widget.product.rate.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.product.images.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: selected == index
                                            ? [
                                                BoxShadow(
                                                    blurRadius: 3,
                                                    color: Colors.black,
                                                    spreadRadius: .005,
                                                    blurStyle: BlurStyle.solid)
                                              ]
                                            : [],
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = index;
                                            pageController.jumpToPage(index);
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 30,
                                          child: Image(
                                            image: NetworkImage(
                                                '${widget.product.images[index]}'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                'Details:',
                                style: TextStyle(fontSize: 20),
                              ),
                              ReadMoreText(
                                '${widget.product.details}',
                                trimLines: 2,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'see more',
                                trimExpandedText: 'less',
                                moreStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: mainColor),
                                lessStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: mainColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      IconBroken.Arrow___Left_2,
                      color: Colors.black,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: cubit.cartItems.contains(widget.product)
                        ? cubit.inCart(widget.product.id, selected)['flag']
                            ? defaultButton(
                                onPressed: () {
                                  cubit.toggleCart(
                                      index: cubit.cartItems
                                          .indexOf(widget.product),
                                      id: widget.product.id,
                                    imageIndex: selected
                                  );
                                },
                                color: Colors.red,
                                icon: const Icon(
                                  Icons.remove_shopping_cart,
                                  color: Colors.white,
                                ),
                                text: 'Remove')
                            : defaultButton(
                                onPressed: () {
                                  cubit.toggleCart(
                                      index: cubit.cart.length,
                                      id: widget.product.id,
                                      imageIndex: selected,
                                      amount: 1,
                                      productIndex: widget.index);
                                },
                                icon: const Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                ),
                                text: 'Add To Cart')
                        : defaultButton(
                            onPressed: () {
                              cubit.toggleCart(
                                  index: cubit.cart.length,
                                  id: widget.product.id,
                                  imageIndex: selected,
                                  amount: 1,
                                  productIndex: widget.index);
                            },
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                            ),
                            text: 'Add To Cart'),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
