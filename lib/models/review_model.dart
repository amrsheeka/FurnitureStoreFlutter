class ReviewModel{
  String? id;
  late String uid;
  late String productId;
  late double rate;
  late String comment;
  ReviewModel(this.uid,this.productId,this.rate,this.comment);

  ReviewModel.fromJson({required Map<String,dynamic> json}){
    id = json['id'];
    uid = json['uid'];
    productId = json['productId'];
    rate = double.parse(json['rate']??'0');
    comment = json['comment'];
  }
  Map<String,dynamic> toJson(){
    return{
      'uid':uid,
      'productId':productId,
      'rate':rate.toString(),
      'comment':comment,
    };
  }
}