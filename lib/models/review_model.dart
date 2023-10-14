class ReviewModel{
  String? id;
  late String uid;
  String? userName='unknown';
  late String productId;
  late double rate;
  late String comment;

  ReviewModel(this.uid,this.userName,this.productId,this.rate,this.comment);

  ReviewModel.fromJson({required Map<String,dynamic> json}){
    id = json['id'];
    uid = json['uid'];
    userName = json['userName'];
    productId = json['productId'];
    rate = double.parse(json['rate']??'0');
    comment = json['comment'];
  }
  Map<String,dynamic> toJson(){
    return{
      'uid':uid,
      'userName':userName,
      'productId':productId,
      'rate':rate.toString(),
      'comment':comment,
    };
  }
}