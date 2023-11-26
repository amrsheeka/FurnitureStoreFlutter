
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/default_button.dart';
import 'package:furniture_store/components/show_toast.dart';
import 'package:furniture_store/cubits/shop_login_cubit/shopLoginCubit.dart';
import 'package:furniture_store/cubits/shop_login_cubit/shopLoginStates.dart';
import '../../cubits/shop_cubit/shopCubit.dart';
import '../../cubits/shop_cubit/states.dart';
import '../../shared/icon_broken.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_2,
                  color: Colors.black,
                ),
              ),
              title: const Text('Verification'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/email.png'))),
                      ),
                    ),
                    const Text('Click send to receive an email to reset your password',style: TextStyle(
                      fontSize: 20,
                    ),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 30,),
                            ConditionalBuilder(
                              condition: state is !ShopChangePasswordLoadingState,
                              builder: (context) => defaultButton(
                                  onPressed: (){
                                      cubit.resetPassword(email: '${cubit.user?.email}');
                                  },
                                  text: 'Send'
                              ),
                              fallback: (context) => const CircularProgressIndicator(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if(state is ShopChangePasswordSuccessState){
            showToast(message: 'Check your email', type: ToastType.SUCCESS);
            Navigator.pop(context);
          }else if(state is ShopChangePasswordErrorState){
            showToast(message: 'Something went wrong', type: ToastType.ERROR);
          }
        },
      ),
    );
  }
}
