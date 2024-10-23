import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../../presentation/view/screens/entry_point/entry_point.dart';
import '../../../../utils/custom_dialog/custom_dialog.dart';
import '../../../../utils/rive_utils.dart';

class PhoneController extends GetxController {

  RxBool isShowLoading = false.obs;
  RxBool isShowConfetti = false.obs;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger confetti;

  // Define TextEditingControllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Get Rive Controller
  StateMachineController getRiveController(Artboard artboard) {
    final controller = RiveUtils.getRiveController(artboard);
    check = controller.findSMI('Check') as SMITrigger;
    error = controller.findSMI('Error') as SMITrigger;

    return controller;
  }

  // Get Rive Controller for confetti animation
  StateMachineController getRiveControllerr(Artboard artboard) {
    final controller = RiveUtils.getRiveController(artboard);
    confetti = controller.findSMI('Trigger explosion') as SMITrigger;
    return controller;
  }

  // Trigger error animation
  void triggerErrorAnimation() {
    error.fire();
  }


  // Sign-Up function
  Future<void> loginWithPhone() async {
    isShowLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    // Validate input
    if (formKey.currentState!.validate()){
      try {
        String username = usernameController.text.trim();
        String email = phoneController.text.trim();
        String otp = otpController.text.trim();



        // // Trigger success animation
        check.fire();
        await Future.delayed(const Duration(seconds: 2));
        isShowLoading.value = false;
        // // Fire confetti animation
        isShowConfetti.value = true;
        confetti.fire();
        await Future.delayed(const Duration(seconds: 1));
       // Navigate to entry point
      } catch (e) {
        // Handle general exceptions
        error.fire();
        isShowLoading.value = false;
      }
    } else {
      // Validation failed
      error.fire();
      await Future.delayed(const Duration(seconds: 2));
      isShowLoading.value = false;
    }
  }


  @override
  void dispose() {
    clearInputFields(); // Ensure all text fields are cleared
    super.dispose();
  }

// Helper function to clear input fields
  void clearInputFields() {
    usernameController.clear();
    phoneController.clear();
    otpController.clear();
  }


}