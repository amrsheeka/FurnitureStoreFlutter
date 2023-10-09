import 'package:furniture_store/models/product_order_model.dart';

class OrderModel{
  String? _id;
  late String uid;
  late String address;
  late double totalAmount;
  List<ProductOrderModel> orderItems=[];

  OrderModel(this.orderItems,this.uid,this.address,this.totalAmount);

  set id(String value) {
    _id = value;
  }

  OrderModel.fromJson({required Map<String,dynamic> json}){
    _id = json['id'];
    uid = json['uid'];
    address = json['address'];
    totalAmount = json['totalAmount'];
    json['orderItems'].forEach((element){
      orderItems.add(ProductOrderModel.fromJson(json: element));
    });
  }
  Map<String,dynamic> toJson(){
    return{
      'id':_id,
      'uid':uid,
      'address':address,
      'totalAmount':totalAmount,
      'orderItems':orderItems.map((e) => e.toJson()).toList(),
    };
  }
}