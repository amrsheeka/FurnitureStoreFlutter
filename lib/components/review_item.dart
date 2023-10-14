import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture_store/models/review_model.dart';

Widget reviewItem({required ReviewModel reviewModel})=>Column(
  children: [
    Row(
      children: [
        Text('${reviewModel.userName}',style: const TextStyle(fontSize: 17,color: Colors.blueGrey),),
        const Spacer(),
        RatingBar.builder(
          initialRating: reviewModel.rate,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemSize: 20,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          ignoreGestures: true,
          onRatingUpdate: (double value){},
        ),
      ],
    ),
    Align(
      alignment: AlignmentDirectional.bottomStart,
        child: Text(reviewModel.comment)
    )
  ],
);