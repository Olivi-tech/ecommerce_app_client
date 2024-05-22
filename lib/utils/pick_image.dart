import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickFile {
  static Future<String> pickImage({required ImageSource imageSource}) async {
    final photo = await ImagePicker().pickImage(source: imageSource);
    if (photo != null) {
      File image = File(photo.path);
      return image.path;
    } else {
      return '';
    }
  }
}
