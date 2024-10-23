import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../presentation/view/screens/entry_point/entry_point.dart';
import '../../../../utils/images/image_strings.dart';
import '../../../models/user_model/UserModel.dart';
import '../../../repositories/user_repo/user_repositories.dart';

class GoogleController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepositories _userRepositories = UserRepositories();

  // Observable variable to track loading state
  RxBool isLoading = false.obs;

  // Google Sign-In method
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

      // Create credentials from Google authentication
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using Google credentials
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  // Google Login Flow with Loading State
  Future<void> loginWithGoogle() async {
    isLoading.value = true; // Start loading

    try {
      final user = await signInWithGoogle();

      if (user != null) {
        // Create UserModel instance with user data
        UserModel userModel = UserModel(
          id: user.uid,
          username: user.displayName ?? 'No Name',
          email: user.email ?? 'No Email',
          phoneNumber: '', // Not provided by Google
          photoUrl: user.photoURL ?? defaultDp,
        );

        // Save user data to Firestore
        await _userRepositories.createUser(userModel);

        // Navigate to EntryPoint screen with user data
        Get.offAll(() => EntryPoint(
          userEmail: user.email ?? 'No Email',
          userName: user.displayName ?? 'No Name',
          userPhotoUrl: user.photoURL ?? defaultDp,
        ));
      } else {
        Get.snackbar('Error', 'Google sign-in failed.');
      }
    } catch (e) {
      print('Error during login: $e');
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
