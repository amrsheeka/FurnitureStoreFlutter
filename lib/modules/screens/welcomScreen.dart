
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/navigation.dart';
import '../../components/on_boarding_item.dart';
import '../../networks/local/CacheHelper.dart';
import '../../shared/constants.dart';
import 'loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var pageViewController = PageController();

  bool isLast = false;

  List<Map<String, dynamic>> onBordingList = [
    {"title": "title1", "body": "body1", "picture": "images/onbording1.png"},
    {"title": "title2", "body": "body2", "picture": "images/onbording1.png"},
    {"title": "title3", "body": "body3", "picture": "images/onbording1.png"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: TextButton(
                onPressed: () {
                  CacheHelper.putData(key: 'onBording', value: false);
                  navigateAndFinish(context: context, page: LoginScreen());
                },
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 20, color: mainColor),
                )),
          ),
          Expanded(
            child: PageView.builder(
                controller: pageViewController,
                physics: BouncingScrollPhysics(),
                itemCount: onBordingList.length,
                onPageChanged: (index) {
                  if (index == onBordingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return onBoardingItem(
                      title: onBordingList[index]['title'],
                      body: onBordingList[index]['body'],
                      picture: onBordingList[index]['picture']);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                    effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 30,
                      activeDotColor: mainColor
                    ),
                    controller: pageViewController,
                    count: onBordingList.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.putData(key: 'onBording', value: false);
                      navigateAndFinish(context: context, page: LoginScreen());
                    } else {
                      pageViewController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },

                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
