import 'package:flutter/cupertino.dart';
import 'package:shooe/models/cart_model.dart';
import 'package:shooe/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addProductToCart(ProductModel product) {
    if(productExist(product)) {
      int index = _carts.indexWhere((element) => element.product.id == product.id);
      _carts[index].quantity++;
      print(_carts[index].quantity);
    } else {
      _carts.add(CartModel(
        id: _carts.length,
        product: product,
        quantity: 1
      ));
    }
    notifyListeners();
  }

  removeProductFromCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  addProductQuantity(int id) {
    _carts[id].quantity++;
    notifyListeners();
  }

  reduceProductQuantity(int id) {
    _carts[id].quantity--;
    if(_carts[id].quantity == 0) {
      removeProductFromCart(id);
      return;
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for(var item in _carts) total += item.quantity;
    return total;
  }

  totalPrice() {
    double total = 0;
    for(var item in _carts) total += item.getTotalPrice();
    return total;
  }

  productExist(ProductModel product) {
    if(_carts.indexWhere((element) => element.product.id == product.id) == -1) return false;
    return true;
  }
}