import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _cartItems = [];
  double _totalPrice = 0.0;
  List<CartModel> get cartItems => _cartItems;



  // Add item to cart
  void addItemToCart(CartModel item) {
    bool found = false;
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].docId == item.docId) {
        _cartItems[i] = CartModel(
          docId: item.docId,
          quantity: _cartItems[i].quantity! + item.quantity!,
          price: item.price,
          imageUrl: item.imageUrl,
          title: item.title,
        );
        found = true;
        break;
      }
    }

    if (!found) {
      _cartItems.add(CartModel(
        docId: item.docId,
        quantity: item.quantity,
        price: item.price,
        imageUrl: item.imageUrl,
        title: item.title,
      ));
    }

    print('Cart Items: $_cartItems'); // Debugging log
    notifyListeners();
  }

  // Remove item from cart
  void removeItemFromCart(String docId) {
    _cartItems.removeWhere((item) => item.docId == docId);
    notifyListeners();
  }

  // Update item quantity in cart
  void updateItemQuantity(String docId, int newQuantity) {
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].docId == docId) {
        _cartItems[i] = CartModel(
          docId: docId,
          quantity: newQuantity,
          price: _cartItems[i].price,
          imageUrl: _cartItems[i].imageUrl,
          title: _cartItems[i].title,
        );
        break;
      }
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

  // Get total number of items in cart
  int get totalItemsInCart {
    int total = 0;
    for (var cartItem in _cartItems) {
      total += cartItem.quantity ?? 0;
    }
    return total;
  }

  // Get total price of items in cart
  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price! * item.quantity!;
    }
    return total;
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
  void removeItem(String docId) {
    final item = _cartItems.firstWhere((element) => element.docId == docId);
    _totalPrice -= item.price!;
    _cartItems.remove(item);
    notifyListeners();
  }
}
