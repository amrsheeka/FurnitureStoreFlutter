
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
    {
      "title": " Discover a World of Elegance",
      "body": "Welcome to Furniture Store, where style meets comfort! We're thrilled to have you on board. Get ready to embark on a journey of discovering exquisite furniture that complements your lifestyle. Swipe through our onboarding screens to explore the endless possibilities of turning your house into a home.",
      "picture": "images/onbording1.png"
    },
    {
      "title": "Dive into Distinctive Designs",
      "body": "At Furniture Store, we believe that every piece of furniture tells a story. From timeless classics to modern marvels, our collections are carefully curated to cater to diverse tastes. Swipe left to explore our range of sofas, tables, beds, and more. Immerse yourself in the world of distinctive designs that speak volumes about your unique style.",
      "picture": "images/onbording1.png"
    },
    {
      "title": "Personalize Your Space",
      "body": "Congratulations on reaching the final onboarding screen! At Furniture Store, we understand that your home is an extension of your personality. Swipe through our customization options and discover how you can tailor our furniture to fit your vision. From colors to fabrics, make each piece uniquely yours. Start creating a space that reflects who you are, one piece of furniture at a time.",
      "picture": "images/onbording1.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextButton(
                onPressed: () {
                  CacheHelper.putData(key: 'onBording', value: false);
                  navigateAndFinish(context: context, page: LoginScreen());
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(fontSize: 20, color: mainColor),
                )),
          ),
          Expanded(
            child: PageView.builder(
                controller: pageViewController,
                physics: const BouncingScrollPhysics(),
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
                    effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 30,
                      activeDotColor: mainColor
                    ),
                    controller: pageViewController,
                    count: onBordingList.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.putData(key: 'onBording', value: false);
                      navigateAndFinish(context: context, page: const LoginScreen());
                    } else {
                      pageViewController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },

                  child: const Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
