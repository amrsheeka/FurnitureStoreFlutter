class ProductModel{
  late String id;
  late String name;
  late String description;
  late String details;
  late String type;
  late double price;
  late double oldPrice;
  late double rate;
  late int numberOfRatings=0;
  List<dynamic>images=[];
  void increaseRate({required double newRate}){
    rate = (numberOfRatings*rate+newRate)/(++numberOfRatings);
  }
  void updateRate({required double oldRate,required double newRate}){
    if(numberOfRatings-1==0){
      rate =0;
    }else{
      rate = (numberOfRatings*rate-oldRate)/(--numberOfRatings);
    }
    increaseRate(newRate: newRate);
  }
  ProductModel.fromJson({required json}){
    id=json['id'];
    name=json['name'];
    description=json['description'];
    details=json['details'];
    type=json['type'];
    price=double.parse(json['price']);
    oldPrice=double.parse(json['oldPrice']);
    rate=double.parse(json['rate']??'0');
    numberOfRatings=int.parse(json['numberOfRatings']??'0');
    images=json['images'];
  }
  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'details': details,
      'type': type,
      'price': price.toString(),
      'oldPrice': oldPrice.toString(),
      'rate': rate.toString(),
      'numberOfRatings': numberOfRatings.toString(),
      'images': images
    };
  }
}