import 'package:shooe/models/product_model.dart';

class MessageModel {
  String message;
  int userId;
  String userName;
  String userPictureUrl;
  bool isFromUser;
  ProductModel product;
  DateTime createdAt;
  DateTime updatedAt;

  MessageModel({
    this.message, this.userId, this.userName, this.userPictureUrl,
    this.isFromUser, this.product, this.createdAt, this.updatedAt
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    userName = json['user_name'];
    userPictureUrl = json['user_picture_url'];
    isFromUser = json['is_from_user'];
    product = json['product'].isEmpty ? UninitializedProductModel() : ProductModel.fromJson(json['product']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user_id': userId,
      'user_name': userName,
      'user_picture_url': userPictureUrl,
      'is_from_user': isFromUser,
      'product': product is UninitializedProductModel ? {} : product.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString()
    };
  }
}