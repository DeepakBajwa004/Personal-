
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../utils/custom_dialog/custom_dialog.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxBool isLoading = false.obs;

  // Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    isLoading.value = true;

    try {
      // Check if email exists in the Firestore users collection
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      print('Checking email: $email');
      print('Number of documents found: ${querySnapshot.docs.length}');

      // If email exists, send reset email
      if (querySnapshot.docs.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
        isLoading.value = false;

        Get.snackbar(
          'Password Reset Email Sent',
          'Please check your email to reset your password.',
        );
      } else {
        isLoading.value = false;

        Get.snackbar(
          'Email Not Found',
          'This email is not registered. Please sign up first.',
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      CustomDialog.show(
        context: Get.context!,
        dialogType: DialogType.error,
        title: 'Error',
        description: e.message ?? 'Something went wrong. Try again.',
      );
    } catch (e) {
      // Handle other exceptions (e.g., network issues)
      isLoading.value = false;
      CustomDialog.show(
        context: Get.context!,
        dialogType: DialogType.error,
        title: 'Error',
        description: 'An unexpected error occurred: $e',
      );
    }
  }

}
