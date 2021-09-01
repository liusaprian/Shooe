import 'package:flutter/cupertino.dart';
import 'package:shooe/models/cart_model.dart';
import 'package:shooe/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice) async {
    try {
      if(await TransactionService().checkout(token, carts, totalPrice))
        return true;
      return false;
    } catch(e) {
      print(e);
      return false;
    }
  }
}