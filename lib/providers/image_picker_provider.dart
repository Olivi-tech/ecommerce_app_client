import 'package:flutter/material.dart';

class ImagePickerProvider with ChangeNotifier {

  String _imageBytes = '';
  String _imageUrl = '';

  String get getImageBytes => _imageBytes;
  String get getImageUrl => _imageUrl;

  set setImageBytes(String image) {
    _imageBytes = image;

    notifyListeners();
  }

  set setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }


}
