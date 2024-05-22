import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constants/app_colors.dart';

class AppUtils {
  static void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        backgroundColor: AppColors.blue,
        textColor: AppColors.white,
        fontSize: 16.0);
  }
}
