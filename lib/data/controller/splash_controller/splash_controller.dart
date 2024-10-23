import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_personal_project/presentation/view/screens/onBoarding_screen/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../presentation/view/screens/auth_screen/verify_email/verify_emaill.dart';
import '../../../presentation/view/screens/entry_point/entry_point.dart';

class CustomSplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen(); // Start navigation logic when controller initializes
  }

  // Function to determine the next screen
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4)); // Simulate splash delay

    final user = FirebaseAuth.instance.currentUser;
    final prefs = await SharedPreferences.getInstance();
    bool? isEmailVerified = prefs.getBool('isEmailVerified') ?? false;

    if (user == null) {
      Get.off(() => const OnBoardingScreen()); // Go to sign-in if no user is found
    } else if (!isEmailVerified) {
      Get.off(() => VerifyEmailScreen(
        userEmail: user.email ?? '',
        userName: user.displayName ?? '',
        userPhotoUrl: user.photoURL ?? '',
      )); // Go to email verification screen
    } else {
      Get.off(() => EntryPoint(
        userEmail: user.email ?? '',
        userName: user.displayName ?? '',
        userPhotoUrl: user.photoURL ?? '',
      )); // Go to the entry point if user is logged in and verified
    }
  }
}