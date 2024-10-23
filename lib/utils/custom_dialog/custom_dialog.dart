import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void show({
    required BuildContext context,
    required DialogType dialogType,
    required String title,
    required String description,
    VoidCallback? onOkPress,
    VoidCallback? onCancelPress,
    bool showCloseIcon = true,
    AnimType animType = AnimType.bottomSlide,
    bool headerAnimationLoop = false,
    String okButtonText = 'OK', // Default OK button text
    String cancelButtonText = 'Cancel', // Default Cancel button text
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: animType,
      headerAnimationLoop: headerAnimationLoop,
      title: title,
      desc: description,
      showCloseIcon: showCloseIcon,
      btnOkOnPress: onOkPress ?? () {},
      btnCancelOnPress: onCancelPress ?? () {},
      btnOkText: okButtonText, // Set the OK button text
      btnCancelText: cancelButtonText, // Set the Cancel button text
      buttonsTextStyle: const TextStyle(color: Colors.black),
    ).show();
  }
}
