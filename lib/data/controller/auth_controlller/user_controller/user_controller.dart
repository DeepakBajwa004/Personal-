import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_personal_project/presentation/view/screens/onBoarding_screen/onboarding_screen.dart';
import '../../../../utils/custom_dialog/custom_dialog.dart';
import '../../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../../utils/exceptions/firebase_exceptions.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';
import '../../../../utils/loading/loading.dart';

class UserController extends GetxController {

  static UserController get instance => Get.find();


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;


  /// Displays a confirmation dialog for logout.
  void showLogoutDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      dialogType: DialogType.warning,
      title: 'Confirm Logout',
      description: 'Are you sure you want to log out?',
      onOkPress: () async {
        // Show loading dialog while logging out
        Get.dialog(
          Obx(() => isLoading.value
              ? const Loading()
              : const SizedBox.shrink()),
          barrierDismissible: false, // Prevent dismissal while loading
        );

        await logout(); // Call logout function
        Get.back(); // Close the loading dialog once logout completes
      },
      onCancelPress: () {
        print('Logout canceled');
        Get.back(); // Close the confirmation dialog
      },
    );
  }

  /// Displays a confirmation dialog for account deletion.
  void showAccountDeleteDialog(BuildContext context) {
    String email = '';
    String password = '';

    CustomDialog.show(
      context: context,
      dialogType: DialogType.warning,
      title: 'Confirm Account Deletion',
      description: 'Are you sure you want to delete your account? This action cannot be undone.',
      onOkPress: () async {
        // Show loading dialog while deleting account
        Get.dialog(
          Obx(() => isLoading.value
              ?  const Loading()
              : const SizedBox.shrink()),
          barrierDismissible: false, // Prevent dismissal while loading
        );

        // Get user credentials for email/password accounts
        if (_auth.currentUser?.providerData.any((element) => element.providerId == 'password') ?? false) {
          // Show a dialog to enter email and password for re-authentication
          final emailController = TextEditingController();
          final passwordController = TextEditingController();

          await showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text(' "Re-authentication Required",'),
                  content:  Column(
                    children: [
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        controller: emailController,
                        placeholder: 'Email',
                        padding: const EdgeInsets.all(10),
                      ),
                      const SizedBox(height: 10),
                      CupertinoTextField(
                        controller: passwordController,
                        placeholder: 'Password',
                        obscureText: true,
                        padding: const EdgeInsets.all(10),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () async {
                          email = emailController.text.trim();
                          password = passwordController.text.trim();
                          // Validate input fields
                          if (email.isEmpty || password.isEmpty) {
                            // Show a message if validation fails
                            Get.snackbar(
                              'Validation Error',
                              'Please fill in all fields.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            try {
                              // Create credentials for re-authentication
                              User? user = _auth.currentUser;
                              if (user != null) {
                                AuthCredential credential = EmailAuthProvider.credential(
                                  email: email,
                                  password: password,
                                );

                                // Re-authenticate the user
                                await user.reauthenticateWithCredential(credential);

                                deleteAccount();

                                Get.snackbar(
                                  'Success',
                                  'Account deleted successfully.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              } else {
                                Get.snackbar(
                                  'Error',
                                  'No user is currently signed in.',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            } catch (e) {
                              // Handle re-authentication errors
                              Get.snackbar(
                                'Authentication Error',
                                'Check your E-mail & Password',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          }
                        },
                        child: const Text('Confirm',style: TextStyle(color: Colors.red),)),
                    TextButton(
                      onPressed: () {
                        Get.back(); // Close the dialog
                      },
                      child: const Text('Cancel',style: TextStyle(color: Colors.blue),),
                    )
                  ],
                );
              });
        }

        // Call account deletion function
        await userAccountDelete(email, password);
        Get.back(); // Close the loading dialog once account deletion completes
      },
      onCancelPress: () {
        print('Account deletion canceled');
        Get.back(); // Close the confirmation dialog
      },
    );
  }

  /// Handles the logout process based on the login provider.
  Future<void> logout() async {
    try {
      isLoading(true); // Set loading state to true
      User? user = _auth.currentUser;

      if (user != null) {
        bool isGoogleLogin = user.providerData.any(
              (element) => element.providerId == 'google.com',
        );

        // Handle Google Sign-in Logout
        if (isGoogleLogin) {
          await _googleSignIn.disconnect();
          await _googleSignIn.signOut();
        }

        // General Logout (for email/password or other providers)
        await _auth.signOut();
        // Clear all input fields

        Get.offAll(() => const OnBoardingScreen()); // Navigate to onboarding screen
      }
    } catch (e) {
      Get.snackbar('Logout Failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false); // Reset loading state
    }
  }

  /// Deletes the user's account.
  // Future<void> userAccountDelete(String email, String password) async {
  //   try {
  //     isLoading(true); // Set loading state to true
  //     User? user = _auth.currentUser;
  //
  //     if (user != null) {
  //       // Check if the user logged in via email/password
  //       if (user.providerData.any((element) => element.providerId == 'password')) {
  //         // Re-authenticate the user
  //         UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //           email: email,
  //           password: password,
  //         );
  //
  //         // Ensure userCredential is valid
  //         if (userCredential.user != null) {
  //           // Delete user data from Firestore
  //           await _firestore.collection('users').doc(user.uid).delete();
  //
  //           // Delete the user account
  //           await userCredential.user!.delete();
  //           print("User account deleted and Firestore document removed");
  //         } else {
  //           Get.snackbar('Error', 'Re-authentication failed.',
  //               snackPosition: SnackPosition.BOTTOM);
  //         }
  //         // // Delete user data from Firestore
  //         // await _firestore.collection('users').doc(user.uid).delete(); // Ensure you replace 'users' with your actual collection name
  //         //
  //         // // Delete the user account
  //         // await userCredential.user!.delete();
  //       } else {
          // Directly delete for Google account or other providers
        //   await _firestore.collection('users').doc(user.uid).delete(); // Ensure you replace 'users' with your actual collection name
        //   await user.delete(); // Delete the user account
        //   await _googleSignIn.disconnect(); // Disconnect Google account if applicable
        // }
  //
  //       print("Navigating to OnBoardingScreen");
  //       Get.offAll(() => const OnBoardingScreen());
  //     } else {
  //       Get.snackbar('Error', 'No user is currently signed in.',
  //           snackPosition: SnackPosition.BOTTOM);
  //     }
  //   } catch (e) {
  //     print("Error occurred: $e");
  //     Get.snackbar('Account Deletion Failed', e.toString(),
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading(false); // Reset loading state
  //   }
  // }

  Future<void> userAccountDelete(String email, String password) async {
    try {
      isLoading(true);
      User? user = _auth.currentUser;

      if (user != null) {
        // Check if the user logged in via email/password
        if (user.providerData.any((element) => element.providerId == 'password')) {
          UserCredential userCredential;

          // Re-authenticate
          try {
            userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
            if (userCredential.user == null) {
              Get.snackbar('Error', 'Re-authentication failed.',
                  snackPosition: SnackPosition.BOTTOM);
              return;
            }
            print("Re-authenticated as ${userCredential.user!.email}");
          } catch (e) {
            print("Re-authentication error: $e");
            Get.snackbar('Error', 'Re-authentication failed: $e',
                snackPosition: SnackPosition.BOTTOM);
            return;
          }

        } else {
          // Directly delete for Google account or other providers
          // Directly delete for Google account or other providers
          await _firestore.collection('users').doc(user.uid).delete(); // Ensure you replace 'users' with your actual collection name
          await user.delete(); // Delete the user account
          await _googleSignIn.disconnect(); // Disconnect Google account if applicable
          Get.offAll((()=> const OnBoardingScreen()));
        }
      } else {
        Get.snackbar('Error', 'No user is currently signed in.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error occurred: $e");
      Get.snackbar('Account Deletion Failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }



  // ======----<<<<Email-Verification---->>>>======= //
  Future<void> sendEmailVerification ()async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const MFormatException();
    } on PlatformException catch(e) {
      throw MPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete User Account
  Future<void> deleteAccount () async {
    try {
      await removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
      Get.offAll((()=> const OnBoardingScreen()));
    } on FirebaseAuthException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const MFormatException();
    } on PlatformException catch(e) {
      throw MPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  // Remove User From Data
  Future<void> removeUserRecord(String userId)async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw MFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }


}
