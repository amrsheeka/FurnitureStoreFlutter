abstract class ShopState{}
class ShopInitialState extends ShopState{}
class ShopGetUserSuccessState extends ShopState{}
class ShopGetCitiesSuccessState extends ShopState{}
class ShopGetCitiesErrorState extends ShopState{
  var error;
  ShopGetCitiesErrorState(this.error);
}
class ShopGetUserErrorState extends ShopState{
  var error;
  ShopGetUserErrorState(this.error);
}
class ShopLogOutState extends ShopState{}
class ShopLoadingState extends ShopState{}
class ShopLoginErrorState extends ShopState{
  var error;
  ShopLoginErrorState({this.error});
}
class ChangeBottomNavigationIndex extends ShopState{}
class ShopHomeLoadingState extends ShopState{}
class ShopGetHomeDataErrorState extends ShopState{
  var error;
  ShopGetHomeDataErrorState({this.error});
}
class ShopGetAllProductsState extends ShopState{}
class ShopGetAllProductsErrorState extends ShopState{
  var error;
  ShopGetAllProductsErrorState({this.error});
}
class ShopAddToFavouriteState extends ShopState{}
class ShopDeleteFromFavouriteState extends ShopState{}
class ShopErrorFavouriteState extends ShopState{
  var error;
  ShopErrorFavouriteState({this.error});
}
class ShopAddToCartState extends ShopState{}
class ShopChangeCartAmountState extends ShopState{
  late String id;
  ShopChangeCartAmountState({required this.id});
}
class ShopDeleteFromCartState extends ShopState{}
class ShopErrorCartState extends ShopState{
  var error;
  ShopErrorCartState({this.error});
}
class ShopChangeCategoryState extends ShopState{}
class ShopGetCategoryByNameState extends ShopState{}
class ShopGetCategoryByNameErrorState extends ShopState{
  var error;
  ShopGetCategoryByNameErrorState({this.error});
}
class ChangeSliderIndexState extends ShopState{}
class SearchWithNameState extends ShopState{}
class ShopChangeCityState extends ShopState{}
class ShopMakeOrderSuccessState extends ShopState{}
class ShopMakeOrderErrorState extends ShopState{
  var error;
  ShopMakeOrderErrorState({this.error});
}
class ShopGetOrdersSuccessState extends ShopState{}
class ShopGetOrdersErrorState extends ShopState{
  var error;
  ShopGetOrdersErrorState({this.error});
}
class ShopGetReviewsSuccessState extends ShopState{}
class ShopGetReviewsErrorState extends ShopState{
  var error;
  ShopGetReviewsErrorState({this.error});
}
class ShopAddReviewSuccessState extends ShopState{}
class ShopAddReviewErrorState extends ShopState{
  var error;
  ShopAddReviewErrorState({this.error});
}
class ShopUpdateReviewSuccessState extends ShopState{}
class ShopUpdateReviewErrorState extends ShopState{
  var error;
  ShopUpdateReviewErrorState({this.error});
}
class ShopGetMyProductReviewSuccessState extends ShopState{}
class ShopGetMyProductReviewErrorState extends ShopState{
  var error;
  ShopGetMyProductReviewErrorState({this.error});
}
class ShopChangeCommentState extends ShopState{}
class ShopChangeRateState extends ShopState{}
class AddAddressLoadingState extends ShopState{}
class AddAddressSuccessState extends ShopState{}
class AddAddressErrorState extends ShopState{
  var error;
  AddAddressErrorState(this.error);
}
class DeleteAddressLoadingState extends ShopState{}
class DeleteAddressSuccessState extends ShopState{}
class DeleteAddressErrorState extends ShopState{
  var error;
  DeleteAddressErrorState(this.error);
}
class ShopChangePasswordLoadingState extends ShopState{}
class ShopChangePasswordSuccessState extends ShopState{}
class ShopChangePasswordErrorState extends ShopState{
  var error;
  ShopChangePasswordErrorState(this.error);
}