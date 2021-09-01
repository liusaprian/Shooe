import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shooe/models/message_model.dart';
import 'package:shooe/models/product_model.dart';
import 'package:shooe/models/user_model.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMessage(UserModel user, bool isFromUser, String message, ProductModel product) async {
    try {
      firestore.collection('messages').add({
        'user_id': user.id,
        'user_name': user.name,
        'user_picture_url': user.profilePhotoUrl,
        'is_from_user': isFromUser,
        'message': message,
        'product': product is UninitializedProductModel ? {} : product.toJson(),
        'created_at': DateTime.now().toString(),
        'updated_at': DateTime.now().toString()
      }).then((value) => print('Message sent!'));
    } catch(e) {
      throw Exception('Failed to send message');
    }

  }

  Stream<List<MessageModel>> getMessagesByUserId({int userId}) {
    try {
      return firestore
          .collection('messages')
          .where('user_id', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
            var result = list.docs.map<MessageModel>((DocumentSnapshot message) {
              print(message.data());
              return MessageModel.fromJson(message.data());
            }).toList();

            result.sort((MessageModel a, MessageModel b) => a.createdAt.compareTo(b.createdAt));
            return result;
          });
    } catch(e) {
      throw Exception(e);
    }
  }
}