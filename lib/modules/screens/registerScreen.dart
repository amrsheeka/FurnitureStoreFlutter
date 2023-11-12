

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/show_alert.dart';
import 'package:furniture_store/cubits/shop_login_cubit/shopLoginStates.dart';
import 'package:furniture_store/modules/screens/loginScreen.dart';
import '../../components/default_button.dart';
import '../../components/default_form_field.dart';
import '../../components/navigation.dart';
import '../../components/show_toast.dart';
import '../../cubits/shop_login_cubit/shopLoginCubit.dart';
import '../../shared/constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = TextEditingController();
    var email = TextEditingController();
    var confirmPassword = TextEditingController();
    var password = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
          builder: (BuildContext context, state) {
            var cubit = ShopLoginCubit.get(context);
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create account',
                      style: TextStyle(fontSize: 30),
                    ),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(

                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              defaultFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your name.';
                                    }
                                    return null;
                                  },
                                  prefixIcon: const Icon(Icons.account_box),
                                  label: 'Name',
                                  controller: name,
                                  keyboardType: TextInputType.name),
                              const SizedBox(
                                height: 30,
                              ),
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
                                  keyboardType: TextInputType.name),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your password.';
                                    }
                                    return null;
                                  },
                                  obscureText: cubit.securedPassword,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      cubit.toggleSecurePassword();
                                    },
                                    icon: cubit.securedPassword
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  label: 'Password',
                                  controller: password,
                                  keyboardType: TextInputType.visiblePassword
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your confirm password.';
                                    }else if(value!=password.text){
                                      return 'The confirm password doesn\'t match.';
                                    }
                                    return null;
                                  },
                                  obscureText: cubit.securedPassword,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      cubit.toggleSecurePassword();
                                    },
                                    icon: cubit.securedPassword
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  label: 'Confirm Password',
                                  controller: confirmPassword,
                                  keyboardType: TextInputType.visiblePassword
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                  condition: state is !ShopRegisterLoadingState,
                                  builder: (context)=>defaultButton(
                                      text: 'Register',
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.register(email: email.text, password: password.text,name: name.text)
                                              .then((value){
                                            navigateTo(
                                                context: context,
                                                page: LoginScreen()
                                            );
                                          })
                                              .catchError((error){});
                                        }
                                      }),
                                  fallback: (context)=>const CircularProgressIndicator()
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account?'),
                                  TextButton(
                                      onPressed: () {
                                        navigateTo(context: context, page: LoginScreen());
                                      }, child: const Text('Login')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {
            if(state is ShopRegisterSuccessState){
              showAlertDialog(context: context);
              // showToast(message: 'Register Successfully, please login', type: ToastType.SUCCESS);
              showAlertDialog(context: context);
            }else if(state is ShopRegisterErrorState){
              showToast(message: 'This email doesn\'t exist' , type: ToastType.ERROR);
            }
          },
        ),
      ),
    );
  }
}
