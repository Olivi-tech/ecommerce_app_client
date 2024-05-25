import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constants/app_colors.dart';

class AppUtils {
  static void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.greyColor,
        textColor: AppColors.black,
        fontSize: 16.0);
  }
}
