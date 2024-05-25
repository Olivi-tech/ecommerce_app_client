import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class DismissibleProvider with ChangeNotifier {
  List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  void addCartItem(CartModel item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeCartItem(String docId) {
    _cartItems.removeWhere((item) => item.docId == docId);
    notifyListeners();
  }

  int get itemCount => _cartItems.length;
}
