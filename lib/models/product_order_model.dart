import 'package:furniture_store/models/productModel.dart';

class ProductOrderModel{
  late ProductModel product;
  late int count;
  late String image;
  ProductOrderModel(this.product, this.count,this.image);

  ProductOrderModel.fromJson({required Map<String,dynamic> json}){
    product=ProductModel.fromJson(json: json['product']);
    count=json['count'];
    image=json['image'];
  }
   Map<String,dynamic> toJson(){
    return{
      'product':product.toJson(),
      'count':count,
      'image':image

    };
  }
}