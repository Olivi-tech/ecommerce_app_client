import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  bool _isFavorited = false;

  bool get isFavorited => _isFavorited;

  void toggleFavorite() {
    _isFavorited = !_isFavorited;
    notifyListeners();
  }
}
