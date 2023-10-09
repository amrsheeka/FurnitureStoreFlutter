abstract class ShopLoginState{}
class ShopLoginInitialState extends ShopLoginState{}
class ShopLoginLoadingState extends ShopLoginState{}
class ShopGoogleLoginLoadingState extends ShopLoginState{}
class ShopLoginSuccessState extends ShopLoginState{}
class ShopLoginErrorState extends ShopLoginState{
  var error;
  ShopLoginErrorState({required error});
}
class ShopRegisterLoadingState extends ShopLoginState{}
class ShopRegisterSuccessState extends ShopLoginState{}
class ShopVerifyEmailState extends ShopLoginState{}
class ShopRegisterErrorState extends ShopLoginState{
  var error;
  ShopRegisterErrorState({required error});
}
class ShopSecurePasswordState extends ShopLoginState{}
class ShopResetPasswordLoadingState extends ShopLoginState{}
class ShopResetPasswordSuccessState extends ShopLoginState{}
class ShopResetPasswordErrorState extends ShopLoginState{
  var error;
  ShopResetPasswordErrorState({required error});
}

