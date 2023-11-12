
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/cubits/shop_cubit/states.dart';
import 'package:furniture_store/models/product_order_model.dart';
import 'package:furniture_store/models/review_model.dart';
import 'package:furniture_store/modules/screens/profile_screen.dart';
import 'package:furniture_store/stripe_payment/payment_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/order_model.dart';
import '../../models/productModel.dart';
import '../../models/userModel.dart';
import '../../modules/screens/orders_creen.dart';
import '../../modules/screens/favoriteScreen.dart';
import '../../modules/screens/homeScreen.dart';
import '../../networks/local/CacheHelper.dart';
import '../../networks/remote/dioHelper.dart';
import '../../shared/constants.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [HomeScreen(), FavoriteScreen(), OrdersScreen(),ProfileScreen()];
  List<String> appBarTitle = ['Home', 'Favorite', 'Orders','Profile'];
  FirebaseFirestore instance = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationIndex());
  }

  Map<String, dynamic> favorite = {};
  List<ProductModel> favoriteItems = [];
  List<CartItemModel> cart = [];
  List<ProductModel> cartItems = [];
  UserModel? user;
  Future<void> getUserData({required String? uid})async {
    instance.collection('users').doc(uid).get().then((value) {
      user = UserModel.fromJson(json: value.data());
      appBarTitle[appBarTitle.length-1]='${user?.name}';
      favorite = user!.favorite;
      cart =user!.cart;
      emit(ShopGetUserSuccessState());
    }).then((value){

      emit(ShopGetUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopGetUserErrorState(error));
    });
  }

  void toggleFavorite({required String id}) {
    if(favorite[id]!=null){
      favorite[id] = !favorite[id];
      if(favorite[id]==true){
        emit(ShopAddToFavouriteState());
      }else{
        emit(ShopDeleteFromFavouriteState());
      }
    }else{
      favorite[id] = true;
      emit(ShopAddToFavouriteState());
    }

    updateUser(favorite: favorite).then((value) {
      getUserData(uid: uid);
      getFavorite();
      if(favorite[id]==true){
        emit(ShopAddToFavouriteState());
      }else{
        emit(ShopDeleteFromFavouriteState());
      }
    }).catchError((error) {
      print(error);
      emit(ShopErrorFavouriteState(error: error));
    });
  }

  void getFavorite(){
    favoriteItems=[];
    for (var element in products) {
      if(favorite['${element.id}']==true){
        favoriteItems.add(element);
      }
    }
  }

  double totalPrice=0;
  double calcTotalPrice(){
    double total=0;
    for (int i=0;i<cartItems.length;i++) {
      total+=cartItems[i].price*cart[i].count;
    }
    totalPrice=total;
    return total;
  }

  void toggleCart({required int index,required String id,int? amount,int? imageIndex,int? productIndex,}) {
    if(amount!=null){
      if(index!=cart.length){
        cart[index]=CartItemModel(id,amount,productIndex!,imageIndex!);
        emit(ShopChangeCartAmountState(id: id));
      }else{
        cart.add(CartItemModel(id,amount,productIndex!,imageIndex!));
        emit(ShopAddToCartState());
      }

    }else{
      cart.removeAt(inCart(id, imageIndex!)['index']);
      emit(ShopDeleteFromCartState());
    }
    updateUser(cart: cart.map((item) => item.toJson()).toList()).then((value) {
      getUserData(uid: uid);
      getCart();
      calcTotalPrice();
      if(amount!=null){
        emit(ShopAddToCartState());
      }else{
        emit(ShopDeleteFromCartState());
      }
    }).catchError((error) {
      print(error);
      emit(ShopErrorCartState(error: error));
    });
  }

  void getCart(){
    cartItems=[];
    cartItems=cart.map((e) => products[e.productIndex]).toList();
    calcTotalPrice();
  }

  Map<String, dynamic> inCart(String id,int imageIndex){
    bool flag=false;
    int index=-1;
    for (int i=0;i<cart.length;i++) {
      if(cart[i].id==id&&cart[i].imageIndex==imageIndex){
        index=i;
        flag=true;
      }
    }
    return {'flag':flag,'index':index};
  }

  Future<void> updateUser({
    String? name,
    String? email,
    String? image,
    List<Map<String,dynamic>>? cart,
    Map<String, dynamic>? favorite,
  }) async {
    Map<String, dynamic> newUser = {
      'uid': uid,
      'name': name ?? user?.name,
      'email': email ?? user?.email,
      'image': image ?? user?.image,
      'cart': cart ?? user?.cart.map((item) => item.toJson()).toList(),
      'favorite': favorite ?? user?.favorite,
    };
    instance
        .collection('users')
        .doc(uid)
        .update(newUser)
        .then((value) {})
        .catchError((error) {});
  }

  List<ProductModel> products = [];
  Future<void> getAllProducts() async {
    instance.collection('products').get().then((value){
      products=[];
      products.addAll(value.docs
          .map((doc) => ProductModel.fromJson(json: {...doc.data(),'id':doc.id}))
          .toList());
      getFavorite();
      getCart();
      search(query: searchQuery);
      emit(ShopGetAllProductsState());
    }).catchError((error){
      emit(ShopGetAllProductsErrorState());
    });

  }

  List<String> categories=['All'];
  Future<void> getCategories()async{
    instance.collection('categories').get().then((value){
      categories.addAll(value.docs
          .map((doc) => doc['type']));
    }).catchError((error){

    });
  }

  String searchQuery='';
  Future<void> getCategoryByName(String name)async{
    instance.collection('products').where('type',isEqualTo: name).get().then((value){
      print(value.docs.length);
      products=[];
      products.addAll(value.docs
          .map((doc) => ProductModel.fromJson(json: doc.data()))
          .toList());
      search(query: searchQuery);
      emit(ShopGetCategoryByNameState());
    }).catchError((error){
      emit(ShopGetCategoryByNameErrorState());
    });
  }

  List<dynamic> slider = [];
  Future<void> getSliders() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await instance.collection('sliders').doc('9EhgJ8wv7mUhuo3QjPCY').get();
    slider = doc['slider'];
  }

  Future<void> getData()async{
    uid=firebaseAuth.currentUser?.uid;
    getUserData(uid: uid).then((value){
      getAllProducts();
      getCategories();
    });
  }

  int selectedCategory=0;
  void changeCategory({required index,required name}){
    selectedCategory=index;
    print(name);
    emit(ShopChangeCategoryState());
    if(name=='All'){
      getAllProducts();
    }else{
      getCategoryByName(name);
    }

  }

  int sliderIndex=0;
  void changeSliderIndex(int index){
    sliderIndex=index;
    emit(ChangeSliderIndexState());
  }

  List<ProductModel> searchResults=[];
  void search({required String query}){

      searchResults=[];
      for (var element in products) {
        if(element.name.toLowerCase().contains(query.toLowerCase())){
          searchResults.add(element);
        }
      }
      emit(SearchWithNameState());

  }
  
  List<dynamic> cities = [];
  Future<void> getCities() async{
    DioHelper.getData(
      url: '9628215e-e31a-4907-bea8-d3cbd8873386',
    ).then((value) {
      cities=value.data.map((e)=>e['city']).toList();
    }).catchError((error) {
      print(error.toString());
    });
  }

  String? selectedCity;
  void changeCity({required String city}){
    selectedCity = city;
    emit(ShopChangeCityState());
  }

  Future<void> makeOrder({required double amount,required String city,required String street})async{
    OrderModel order;
    List<ProductOrderModel> orderItems=[];
    for(int i=0;i<cart.length;i++){
    orderItems.add(ProductOrderModel(cartItems[i], cart[i].count,cartItems[i].images[cart[i].imageIndex]));
    }
    order=OrderModel(orderItems,uid!,'$city, $street',amount);
    PaymentManager.makePayment(amount.round(), 'USD').then((value){
      if(value){
        instance.collection('orders').add(order.toJson()).then((value){
          order.id=value.id;
          instance.collection('orders').doc(value.id).update(order.toJson()).then((value){
            getOrders();
            emit(ShopMakeOrderSuccessState());
          }).catchError((error){
            print(error);
            emit(ShopMakeOrderErrorState(error: error));
          });
        });
      }
    }).catchError((error){
      print('error: $error');
      emit(ShopMakeOrderErrorState(error: error));
    });
  }

  List<OrderModel> orders=[];
  Future<void> getOrders()async{
    instance.collection('orders').where('uid',isEqualTo: uid).get().then((value) {
      orders.addAll(value.docs
          .map((doc) => OrderModel.fromJson(json: doc.data()))
          .toList());
      emit(ShopGetOrdersSuccessState());
    }).catchError((error){
      print(error);
      emit(ShopGetOrdersErrorState(error: error));
    });
  }
  QueryDocumentSnapshot<Map<String, dynamic>>? oldDoc;
  String? initialComment;
  double initialRate=1;
  Future<void> makeRating({
    required double rate,
    required String comment,
    required ProductModel product
  })async{
    ProductModel productModel = product;
    await getMyProductReview(productId: productModel.id);
    if(oldDoc!=null){
      productModel.updateRate(oldRate: double.parse(oldDoc?['rate']),newRate: rate);
      ReviewModel reviewModel = ReviewModel(uid!,user?.name, product.id, rate, comment);
      instance.collection('reviews').doc(oldDoc?.id).update(reviewModel.toJson()).then((value){
        emit(ShopUpdateReviewSuccessState());
        updateProductRate(productModel);
      }).catchError((error){
        emit(ShopUpdateReviewErrorState(error: error));
      });
    }else{
      productModel.increaseRate(newRate: rate);
      ReviewModel reviewModel = ReviewModel(uid!,user?.name, product.id, rate, comment);
      instance.collection('reviews').add(reviewModel.toJson()).then((value){
        emit(ShopAddReviewSuccessState());
        updateProductRate(productModel);
      }).catchError((error){
        emit(ShopAddReviewErrorState(error: error));
      });
    }

  }
  Future<void> updateProductRate(ProductModel productModel)async{
    instance.collection('products').doc(productModel.id).update(productModel.toJson()).then((value){
      getReviews(productId: productModel.id);
      emit(ShopAddReviewSuccessState());
    }).catchError((error){
      emit(ShopAddReviewErrorState(error: error));
    });
  }
  Future<void> getMyProductReview({required String productId})async{

    var querySnapshot = await instance.collection('reviews')
        .where('uid',isEqualTo: uid,)
        .where('productId',isEqualTo: productId)
        .get();
    if(querySnapshot.docs.isEmpty){
      oldDoc = null;
      initialComment = null;
      initialRate =1;
    }
    for(var doc in querySnapshot.docs){
      oldDoc = doc;
      initialComment = doc['comment'];
      initialRate = double.parse(doc['rate']);
      emit(ShopAddReviewSuccessState());
    }
  }
  void changeComment(String? comment){
    initialComment = comment;
    emit(ShopChangeCommentState());
  }
  void changeRate(double rate){
    initialRate = rate;
    emit(ShopChangeRateState());
  }
  List<ReviewModel> reviews=[];
  Future<void> getReviews({required String productId})async{
    instance.collection('reviews')
        .where('productId',isEqualTo: productId)
        .get().then((value){
          reviews = value.docs.map((doc) => ReviewModel.fromJson(json: doc.data())).toList();
          emit(ShopGetReviewsSuccessState());
    }).catchError((error){
      emit(ShopGetReviewsErrorState(error: error));
    });
  }
  Future<void> logOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    CacheHelper.deleteData(key: 'uid');
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
    emit(ShopLogOutState());
  }

}
