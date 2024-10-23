// sign_up_controller.dart
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_personal_project/data/controller/auth_controlller/verify_email_controller/verify_email_controller.dart';
import 'package:my_personal_project/presentation/view/screens/auth_screen/verify_email/verify_emaill.dart';
import 'package:rive/rive.dart';
import '../../../../presentation/view/screens/entry_point/entry_point.dart';
import '../../../../utils/custom_dialog/custom_dialog.dart';
import '../../../../utils/rive_utils.dart';
import '../../../models/user_model/UserModel.dart';
import '../../../repositories/user_repo/user_repositories.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepositories _userRepositories = UserRepositories();

  RxBool isShowLoading = false.obs;
  RxBool isShowConfetti = false.obs;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger confetti;

  // Define TextEditingControllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
  Future<void> signUp() async {
    isShowLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    // Validate input
   if (formKey.currentState!.validate()){
     try {
       String username = usernameController.text.trim();
       String email = emailController.text.trim();
       String password = passwordController.text.trim();


       // Create user
       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
         email: email,
         password: password,
       );


       // Update user profile with display name and photo URL
       await userCredential.user?.updateProfile(
         displayName: username,
         photoURL: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ16Lx_jsUPFnT9-8wFWyIiBzRM_iGvaSpn8A&s', // Use a valid image URL
       );



       // Create UserModel instance
       UserModel user = UserModel(
         id: userCredential.user!.uid,
         username: username,
         email: email,
         photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ16Lx_jsUPFnT9-8wFWyIiBzRM_iGvaSpn8A&s',
       );





       // // Trigger success animation
       // check.fire();
        await Future.delayed(const Duration(seconds: 2));
       //
        isShowLoading.value = false;
       // // Fire confetti animation
       // isShowConfetti.value = true;
       // confetti.fire();
        await Future.delayed(const Duration(seconds: 1));
       // Clear text fields before navigation
       // Navigate to entry point
       // Get.offAll(() => EntryPoint(
       //   userEmail: user.email,
       //   userName: user.username,
       //   userPhotoUrl: user.photoUrl,
       // ));


       Get.to(()=>  VerifyEmailScreen(
         userEmail:   email,
         userName:  username,
         userPhotoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ16Lx_jsUPFnT9-8wFWyIiBzRM_iGvaSpn8A&s',
       ));
       //
       //
        clearInputFields();


     }  on FirebaseAuthException catch (e) {
       // Handle errors
       error.fire();
       isShowLoading.value = false;
       String errorMessage;
       if (e.code == 'email-already-in-use') {
         errorMessage = 'This email is already registered.';
       } else if (e.code == 'invalid-email') {
         errorMessage = 'Invalid email address.';
       } else if (e.code == 'weak-password') {
         errorMessage = 'Password is too weak.';
       } else {
         errorMessage = 'An unexpected error occurred.';
       }

       CustomDialog.show(
         context: Get.context!,
         dialogType: DialogType.error,
         title: 'Sign Up Failed',
         description: errorMessage,
       );
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
    emailController.clear();
    passwordController.clear();
  }

}
