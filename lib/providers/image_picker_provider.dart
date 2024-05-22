import 'package:flutter/foundation.dart';

class ImagePickerProvider extends ChangeNotifier {
  String _imagePath = '';
  bool _isLoading = false;

  String get getImage => _imagePath;

  bool get isLoading => _isLoading;

  set setImage(String imagePath) {
    _imagePath = imagePath;
    _isLoading = false;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get pickImage => _imagePath.isNotEmpty;
}
