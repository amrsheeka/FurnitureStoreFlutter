class UserModel{
  String? uid;
  String? email;
  String? name;
  String image='https://t4.ftcdn.net/jpg/02/23/50/73/360_F_223507349_F5RFU3kL6eMt5LijOaMbWLeHUTv165CB.jpg';
  List<CartItemModel> cart= [];
  Map<String,dynamic> favorite= {};
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
  });
  UserModel.fromJson({required Map<String,dynamic>? json}){
    uid=json!['uid'];
    email=json['email'];
    name=json['name'];
    image=json['image'];
    json['cart'].forEach((e){
      cart.add(CartItemModel.fromJson(json: e));
    });
    favorite=json['favorite']?? {};
  }
  Map<String,dynamic> toJson(){
    return{
      'uid':uid,
      'email':email,
      'name':name,
      'image':image,
      'cart': cart.isEmpty?[]:cart.map((item) => item.toJson()).toList(),
      'favorite':favorite
    };
  }

}
class CartItemModel{
  late String id;
  late int count;
  late int productIndex;
  late int imageIndex;
  CartItemModel(this.id,this.count,this.productIndex,this.imageIndex);
  CartItemModel.fromJson({required Map<String,dynamic>? json}){
    id=json!['id'];
    count=json['count'];
    productIndex=json['productIndex'];
    imageIndex=json['imageIndex'];

  }
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'count':count,
      'productIndex':productIndex,
      'imageIndex':imageIndex,

    };
  }
}