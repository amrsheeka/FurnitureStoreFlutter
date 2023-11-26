
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/default_button.dart';
import 'package:furniture_store/components/default_form_field.dart';
import 'package:furniture_store/components/navigation.dart';
import 'package:furniture_store/components/show_toast.dart';
import 'package:furniture_store/cubits/shop_login_cubit/shopLoginCubit.dart';
import 'package:furniture_store/cubits/shop_login_cubit/shopLoginStates.dart';
import '../../shared/constants.dart';
import '../../shared/icon_broken.dart';
import 'loginScreen.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginState>(
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
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
              title: Text('Verification'),
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
                    const Text('Type your email to reset your password',style: TextStyle(
                      fontSize: 20,
                    ),textAlign: TextAlign.center,),
                    const SizedBox(height: 30,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 10,),
                              defaultFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your email.';
                                    }else if(!emailValid.hasMatch(value)){
                                      return 'Enter a valid email, EX: example@ex.com';
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.email),
                                  label: 'Email',
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress
                              ),
                              const SizedBox(height: 30,),
                              ConditionalBuilder(
                                  condition: state is !ShopResetPasswordLoadingState,
                                  builder: (context) => defaultButton(
                                      onPressed: (){
                                        if(formKey.currentState!.validate()){
                                          cubit.resetPassword(email: email.text).then((value){
                                          });
                                          
                                        }
                                      },
                                      text: 'Send'
                                  ),
                                  fallback: (context) => const CircularProgressIndicator(),
                              )
                            ],
                          ),
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
          if(state is ShopResetPasswordSuccessState){
            showToast(message: 'Check Email', type: ToastType.SUCCESS);
            navigateAndFinish(context: context, page: const LoginScreen());
          }else if(state is ShopResetPasswordErrorState){
            showToast(message: 'This email is not registered', type: ToastType.ERROR);
          }
        },
      ),
    );
  }
}
