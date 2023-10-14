import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture_store/components/default_form_field.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/models/productModel.dart';
import 'package:furniture_store/shared/icon_broken.dart';

import 'default_button.dart';

Future<void> showRatingAlertDialog({
  required context,
  required ShopCubit cubit,
  required ProductModel product
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {

      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            titlePadding: const EdgeInsetsDirectional.only(top: 10,bottom: 5,start: 10),
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Expanded(
                  child: RatingBar.builder(
                    initialRating: cubit.initialRate,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      cubit.changeRate(rating);
                    },
                  ),
                ),
                IconButton(
                    onPressed: (){
                      cubit.changeComment(null);
                      cubit.changeRate(1);
                      Navigator.pop(context);
                    },
                    splashRadius: 1,
                    icon: const Icon(Icons.close))
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  defaultFormField(
                      label: 'Comment',
                      initialValue: cubit.initialComment,
                      onChanged: (value){
                        cubit.changeComment(value);
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 5, // <-- SEE HERE
                      //prefixIcon: const Icon(IconBroken.Chat)
                  )
                ],
              ),
            ),
            actions: <Widget>[
              const Icon(Icons.star,size: 30,color: Colors.amber,),
              Text(
                cubit.initialRate.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              defaultButton(
                  onPressed: (){
                    cubit.makeRating( rate: cubit.initialRate, comment: cubit.initialComment??'', product: product).then((value){
                      cubit.changeComment(null);
                      cubit.changeRate(1);
                      Navigator.pop(context);
                    });
                  },
                  icon: const Icon(
                    IconBroken.Send,
                    color: Colors.white,
                  ),
                  text: 'Post'
              ),
            ],
          );
        },

      );
    },
  );
}