import 'package:cleaning_duty_project/core/colors/app_color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void showErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: AppColor.colorToastError,
        textColor: AppColor.colorWhite,
        fontSize: 12);
  }

  static void showSuccessMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: AppColor.colorToastSuccess,
        textColor: AppColor.colorWhite,
        fontSize: 12);
  }
}
