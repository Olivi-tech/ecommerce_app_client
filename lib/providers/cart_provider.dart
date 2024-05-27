import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> _cartItems = [];
  // Add item to cart
  void addItemToCart(CartModel item) {
    // Check if the item already exists in cart
    bool found = false;
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].docId == item.docId) {
        // Increase quantity if item already exists
        _cartItems[i] = CartModel(
          docId: item.docId,
          quantity: _cartItems[i].quantity! + item.quantity!,
        );
        found = true;
        break;
      }
    }

    if (!found) {
      _cartItems.add(CartModel(
        docId: item.docId,
        quantity: item.quantity,
      ));
    }
    notifyListeners();
  }

  // Get item count by docId
  int getCartItemCountByDocId(String docId) {
    int count = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].docId == docId) {
        count += _cartItems[i].quantity!;
      }
    }
    return count;
  }

  // Upload cart items to Firebase
  void uploadCartItemsToFirebase() {
    _cartItems.forEach((item) {
      print('Uploading ${item.docId} with quantity ${item.quantity} to Firebase');
    });
  }
  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price! * item.quantity!;
    }
    return total;
  }
}

class CartItem {
  final String docId;
  final int quantity;

  CartItem({
    required this.docId,
    required this.quantity,
  });
}
