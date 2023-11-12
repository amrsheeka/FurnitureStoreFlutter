import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:furniture_store/components/show_toast.dart';
import 'package:furniture_store/cubits/connection_cubit/connection_cubit.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/shared/constants.dart';
import 'package:furniture_store/stripe_payment/stripe_keys.dart';
import 'cubits/connection_cubit/connection_states.dart';
import 'layouts/shopLayout.dart';
import 'modules/screens/loginScreen.dart';
import 'modules/screens/welcomScreen.dart';
import 'networks/local/CacheHelper.dart';
import 'networks/remote/dioHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=ApiKeys.publishableKey;
  await Firebase.initializeApp();
  await CacheHelper.init();
  await DioHelper.init();
  bool? welcome = CacheHelper.getData(key: 'onBording');
  uid = CacheHelper.getData(key: 'uid');
  print("uid: $uid");
  runApp(MyApp(welcome: welcome, uid: uid));
}

class MyApp extends StatelessWidget {
  String? uid;
  bool? welcome;
  // const MyApp({Key? key}) : super(key: key);
  MyApp({Key? key, required this.welcome, required this.uid}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget initialScreen;
    if (welcome == null) {
      initialScreen = WelcomeScreen();
    } else if (uid == null) {
      initialScreen = LoginScreen();
    } else {
      initialScreen = ShopLayout();
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getData()
            ..getSliders()
            ..getCities()
            ..getOrders(),
        ),
        BlocProvider(
          create: (BuildContext context) => ConnectionCubit()..checkConnection()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Jannah',
          textTheme: const TextTheme(),
          buttonTheme: const ButtonThemeData(
            buttonColor: mainColor,
          ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Jannah',
              ),
              color: Colors.white,
              elevation: 0.0,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.white)),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: mainColor, secondary: mainColor),
        ),
        home: BlocConsumer<ConnectionCubit,ShopConnectionState>(
          builder: (context, state) {
            return initialScreen;
          },
          listener: (context, state) {
            if(state is ConnectedState){
            }else if(state is NotConnectedState){
              showToast(message: 'No internet connection', type: ToastType.ERROR);
            }
          },
        ),
      ),
    );
  }
}
