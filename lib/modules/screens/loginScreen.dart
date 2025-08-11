import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/components/line.dart';
import 'package:furniture_store/cubits/shop_login_cubit/shopLoginStates.dart';
import 'package:furniture_store/layouts/shopLayout.dart';
import 'package:furniture_store/modules/screens/registerScreen.dart';
import 'package:furniture_store/modules/screens/reset_password_screen.dart';
import '../../components/default_button.dart';
import '../../components/default_form_field.dart';
import '../../components/navigation.dart';
import '../../components/show_toast.dart';
import '../../cubits/shop_login_cubit/shopLoginCubit.dart';
import '../../shared/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
          builder: (BuildContext context, state) {
            var cubit = ShopLoginCubit.get(context);
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/onbording1.png'))),
                        ),
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(fontSize: 40),
                      ),
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                defaultFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter your email.';
                                      } else if (!emailValid.hasMatch(value)) {
                                        return 'Enter a valid email, EX: example@ex.com';
                                      }
                                      return null;
                                    },
                                    prefixIcon: const Icon(Icons.email),
                                    label: 'Email',
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress),
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
                                    keyboardType: TextInputType.visiblePassword),
                                Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: TextButton(
                                      onPressed: () {
                                        navigateTo(
                                            context: context,
                                            page: ResetPassword());
                                      },
                                      child: const Text('Forgot password?')),
                                ),
                                Container(
                                  width:180,
                                  child: Center(
                                    child: ConditionalBuilder(
                                        condition: state is! ShopLoginLoadingState,
                                        builder: (context) => defaultButton(
                                            text: 'Login',
                                            onPressed: () {
                                              if (formKey.currentState!.validate()) {
                                                cubit
                                                    .login(
                                                        email: email.text,
                                                        password: password.text,
                                                    context: context)
                                                    .then((value) {})
                                                    .catchError((error) {});
                                              }
                                            }),
                                        fallback: (context) =>
                                            const CircularProgressIndicator()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Don\'t have an account?',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          navigateTo(
                                              context: context,
                                              page: RegisterScreen());
                                        },
                                        child: const Text('Register')
                                    ),
              
              
                                  ],
                                ),
                                line(inlineText: 'Or Continue with'),
                                const SizedBox(height: 10,),
                                Container(
                                  width:180,
                                  child: Center(
                                    child: ConditionalBuilder(
                                        condition: state is! ShopGoogleLoginLoadingState,
                                        builder: (context) => InkWell(
                                          child: Container(
                                              width: 180,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  color: Colors.black),
                                              child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 30.0,
                                                        width: 30.0,
                                                        decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'images/google.png'),
                                                              fit: BoxFit.cover),
                                                          shape: BoxShape.circle,
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Google',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white),
                                                      ),
                                                    ],
                                                  ))),
                                          onTap: () {
                                            cubit.loginWithGoogle(context: context);
                                          },
                                        ),
                                        fallback: (context) =>
                                        const CircularProgressIndicator()),
                                  ),
                                ),
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
          listener: (BuildContext context, Object? state) {
            if (state is ShopLoginSuccessState) {
              navigateAndFinish(context: context, page: ShopLayout());
              showToast(message: 'Login Successfully', type: ToastType.SUCCESS);
            } else if (state is ShopLoginErrorState) {
              showToast(
                  message: 'Your email or password are incorrect',
                  type: ToastType.ERROR);
            } else if (state is ShopVerifyEmailState) {
              showToast(
                  message: 'Please verify your email', type: ToastType.WARNING);
            }
          },
        ),
      ),
    );
  }
}
