import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_store/cubits/shop_cubit/shopCubit.dart';
import 'package:furniture_store/cubits/shop_login_cubit/shopLoginStates.dart';
import 'package:furniture_store/models/userModel.dart';
import 'package:furniture_store/networks/local/CacheHelper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../shared/constants.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  bool securedPassword = true;
  void toggleSecurePassword() {
    securedPassword = !securedPassword;
    emit(ShopSecurePasswordState());
  }

  Future<void> login({required String email,required String password ,required context})async{
    emit(ShopLoginLoadingState());
    ShopCubit shopCubit = ShopCubit.get(context);
    fireBaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      if(value.user!.emailVerified){
        uid=value.user?.uid;
        CacheHelper.putData(key: 'uid', value: uid);
        shopCubit.getUserData(uid: uid).then((value){
          shopCubit.getOrders();
        });
        emit(ShopLoginSuccessState());
      }else{
        emit(ShopVerifyEmailState());
      }

    }).catchError((error){
      print("$error");
      emit(ShopLoginErrorState(error: error));
    });
  }
  Future<String?> register({required String email,required String password,required String name})async{
    emit(ShopRegisterLoadingState());
    fireBaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      UserModel user =UserModel(email: email, uid: value.user?.uid, name: name);
      senEmailVerification();
      createUser(user);
      emit(ShopRegisterSuccessState());
    }).catchError((error){
      print(error);
      emit(ShopRegisterErrorState(error: error));
    });
    return null;
  }
  void createUser(UserModel user){

      FirebaseFirestore.instance.collection('users').doc(user.uid??'').set(user.toJson())
      .then((value){

      }).catchError((error){
        print(error);
      });
  }
  Future<void> resetPassword({required String email}) async {
    emit(ShopResetPasswordLoadingState());
    await fireBaseAuth
        .sendPasswordResetEmail(email: email)
        .then((value) {
          emit(ShopResetPasswordSuccessState());
    })
        .catchError((error) {
          print(error);
          emit(ShopResetPasswordErrorState(error: error));
    });
  }
  Future<void> senEmailVerification()async {
    fireBaseAuth.currentUser?.sendEmailVerification();
  }

  Future<void> loginWithGoogle({required context})async {
    emit(ShopGoogleLoginLoadingState());
    ShopCubit shopCubit = ShopCubit.get(context);
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    var authResult = await fireBaseAuth.signInWithCredential(credential);
    var user = authResult.user;
    // assert(!authResult.user!.isAnonymous);
    // assert(await authResult.user?.getIdToken() != null);
    assert(authResult.user?.uid == fireBaseAuth.currentUser?.uid);
    uid = user?.uid;
    CacheHelper.putData(key: 'uid', value: user?.uid);
    var userExist= await _checkIfDocExists(uid!);
    if(!userExist){
      UserModel userModel =UserModel(email: user?.email, uid: user?.uid, name: user?.displayName);
      createUser(userModel);
    }
    shopCubit.getUserData(uid: user?.uid).then((value){
      shopCubit.getOrders();
    });
    emit(ShopLoginSuccessState());
    print(user?.email);
  }
  Future<bool> _checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = fireStore.collection('users');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      emit(ShopLoginErrorState(error: e));
      throw e;
    }
  }
}
