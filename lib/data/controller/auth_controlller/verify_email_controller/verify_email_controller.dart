import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../presentation/view/screens/entry_point/entry_point.dart';
import '../../../models/user_model/UserModel.dart';
import '../../../repositories/user_repo/user_repositories.dart';
import '../user_controller/user_controller.dart';

class VerifyEmailController extends GetxController {

  final String userName;  // Username from signup process
  final String userPhotoUrl;  // Optional photo URL
  final UserRepositories _userRepositories = UserRepositories();

  Timer? _verificationTimer;
  final int verificationTimeout = 10; // Timeout in seconds (10 seconds)

  VerifyEmailController({required this.userName, required this.userPhotoUrl});


  //<<<<<<<<< ----Send email whenever verify screen appears & Set Timer for auto redirect --->>>>>>>>>//
  @override
  void onInit() {
    _setVerificationInProgress(true);
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }


  // Set verification progress flag
  Future<void> _setVerificationInProgress(bool inProgress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isVerificationInProgress', inProgress);
  }
  //<<<<<<<<---Send Email Verification link--->>>>>>>>//
  sendEmailVerification () async {
    try {
      await UserController.instance.sendEmailVerification();
      Get.snackbar('Email Sent' , 'Please Check your inbox and verify your email') ;
    } catch(e) {
      Get.snackbar('Error' , 'Try again after some time') ;
    }
  }


//<<<<<<<<<---Timer to automatically redirect on email verification--->>>>>>>>>//
  setTimerForAutoRedirect () {
    Timer.periodic(const Duration(seconds: 1), (timer)async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false ){
        timer.cancel();
        await storeUserData(user!);   // Store user data
        _verificationTimer?.cancel(); // Stop deletion timer
        _setVerificationInProgress(false); // Clear the verification flag
        print("user emmaillllkjhugvdjsnksadshbfsjakmljidfhbskfhbdsdhfbd ${user.email}");
        print("user emmaillllkjhugvdjsnksadshbfsjakmljidfhbskfhbdsdhfbd ${user.displayName}");
        navigateToEntryPoint();
      }
    });
  }



  //<<<<<<---manually check if email verified>>>>>>>----//
  checkEmailVerificationStatus () async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      navigateToEntryPoint();
    }
  }

  Future<void> storeUserData(User user) async {

    String photoUrl = userPhotoUrl.isNotEmpty
        ? userPhotoUrl
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ16Lx_jsUPFnT9-8wFWyIiBzRM_iGvaSpn8A&s';

    UserModel newUser = UserModel(
      id: user.uid,
      username: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: photoUrl,
    );
    await _userRepositories.createUser(newUser);
  }
  //<<<<<<--- Navigate to EntryPoint with user details --->>>>>>>//
  void navigateToEntryPoint() {
    final user = FirebaseAuth.instance.currentUser;
    Get.off(() => EntryPoint(
      userEmail: user!.email ?? '',
      userName: user.displayName ?? '',
      userPhotoUrl: user.photoURL ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ16Lx_jsUPFnT9-8wFWyIiBzRM_iGvaSpn8A&s',
    ));
  }

  @override
  void onClose() {
    _verificationTimer?.cancel(); // Cancel the timer on controller close
    super.onClose();
  }

}
