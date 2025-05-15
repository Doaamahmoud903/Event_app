import 'package:event_app/utils/app_colors.dart';
import 'package:event_app/widgets/custom_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void showSuccessToast(String msg) {
    CustomToast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.greenColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.0,
    );
  }

  static void showErrorToast(String msg) {
    CustomToast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.errorColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.0,
    );
  }

  static void showLoadingToast(String msg) {
    CustomToast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.0,
    );
  }
}
