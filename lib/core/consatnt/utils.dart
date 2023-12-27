import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void showGetXToast({String? title, String? message, Color? toastColor, Color textColor = Colors.black}) {
    // if (!Get.isSnackbarOpen)
    Get.snackbar("", '',
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 0,
        backgroundColor: toastColor!.withOpacity(0.2),
        messageText: Text(
          message!,
          style: TextStyle(color: textColor.withOpacity(0.75), fontSize: 16, fontWeight: FontWeight.normal, fontFamily: ('Bahij')),
        ),
        titleText: Text(
          title!,
          style: TextStyle(
            color: textColor.withOpacity(0.75),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: ('Bahij'),
          ),
        ),
        //maxWidth: ,
        barBlur: 3,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        duration: Duration(milliseconds: 2000)
        // icon: Image.asset(
        //   "assets/images/success_toast.png",
        //   height: 25,
        //   width: 25,
        //   color: Colors.white,
        // ),
        );
  }
}
