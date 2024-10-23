import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_personal_project/presentation/view/screens/auth_screen/verify_email/verify_emaill.dart';
import 'package:rive/rive.dart';
import '../../../../presentation/view/screens/entry_point/entry_point.dart';
import '../../../../utils/custom_dialog/custom_dialog.dart';
import '../../../../utils/rive_utils.dart';
import '../../../models/user_model/UserModel.dart';
import '../../../repositories/user_repo/user_repositories.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepositories _userRepositories = UserRepositories();

  RxBool isShowLoading = false.obs;
  RxBool isShowConfetti = false.obs;
  RxBool isChecked = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger confetti;

  // Get Rive Controller for error & success animations
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

  // Sign-In function with Firebase Authentication and email verification check
  Future<void> signIn() async {
    isShowLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    if (formKey.currentState!.validate()) {
      try {
        // Extract email and password
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        print('Attempting to sign in with email: $email');

        // Attempt to sign in the user
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Ensure the user's latest state is loaded
        await _auth.currentUser?.reload();
        final user = _auth.currentUser;

        if (user == null) {
          throw Exception('User could not be loaded.');
        }

        // Check if the email is verified
        if (userCredential.user?.emailVerified ?? true) {
          print('Email verified, fetching user details...');

          // Fetch user details using UserRepositories
          UserModel? userModel = await _userRepositories.getUserDetails();

          if (userModel != null) {
            print('User data retrieved: ${userModel.username}');

            // Trigger success animation
            check.fire();
            await Future.delayed(const Duration(seconds: 2));

            isShowLoading.value = false;

            // Fire confetti animation and navigate to EntryPoint
            isShowConfetti.value = true;
            confetti.fire();
            await Future.delayed(const Duration(seconds: 1));

            print('uytrxfdgahdsjiodhuvgh ${userModel.email + userModel.username}');
            Get.offAll(() => EntryPoint(
              userEmail: userModel.email,
              userName: userModel.username,
              userPhotoUrl: userModel.photoUrl,
            ));

          } else {
            print('User data is null, cannot navigate.');
            throw Exception('User data could not be retrieved.');
          }
        } else {
          // User's email is not verified
          await _auth.signOut();
          isShowLoading.value = false;

          CustomDialog.show(
            okButtonText: 'Verify',
            context: Get.context!,
            dialogType: DialogType.warning,
            title: 'Email Not Verified',
            description: 'Please verify your email before logging in.',
            onOkPress: () {
              Get.to(()=> const VerifyEmailScreen(
                  userName: '',
                  userEmail: '',
                  userPhotoUrl: ''
              ));
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        handleAuthError(e); // Handle Firebase exceptions
      }
    } else {
      handleValidationError(); // Handle form validation failure
    }
  }

  // Handle Firebase exceptions
  void handleAuthError(FirebaseAuthException e) {
    error.fire();
    isShowLoading.value = false;

    String errorMessage;
    if (e.code == 'user-not-found') {
      errorMessage = 'No user found with this email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Incorrect password.';
    } else {
      errorMessage = 'Check your email & password.';
    }

    CustomDialog.show(
      context: Get.context!,
      dialogType: DialogType.error,
      title: 'Login Failed',
      description: errorMessage,
    );
  }
  //
  // // Handle general exceptions
  // void handleGeneralError() {
  //   error.fire();
  //   isShowLoading.value = false;
  //
  //   CustomDialog.show(
  //     context: Get.context!,
  //     dialogType: DialogType.error,
  //     title: 'Error',
  //     description: 'An unexpected error occurred.',
  //   );
  // }

  // Handle validation failure
  void handleValidationError() {
    error.fire();
    Future.delayed(const Duration(seconds: 2));
    isShowLoading.value = false;
  }

  // Override onClose to dispose of controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose(); // Call the superclass method
  }
}
