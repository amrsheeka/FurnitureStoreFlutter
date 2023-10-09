import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
 static SharedPreferences? sharedPreferences;

 static init()async{
   sharedPreferences=await SharedPreferences.getInstance();
 }
 static Future<bool>? putData({required key,required value}){
   if(value is int){
     return sharedPreferences?.setInt(key, value);
   }else if(value is String){
     return sharedPreferences?.setString(key, value);
   }else if(value is double) {
     return sharedPreferences?.setDouble(key, value);
   }
   return sharedPreferences?.setBool(key, value);
 }
 static dynamic getData({required key}){
   return sharedPreferences?.get(key);
 }
 static Future<bool>? deleteData({required key}){
   return sharedPreferences?.remove(key);
 }
}