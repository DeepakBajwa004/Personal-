// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:my_personal_project/presentation/view/screens/onBoarding_screen/onboarding_screen.dart';
// import '../../../utils/exceptions/firebase_auth_exceptions.dart';
// import '../../../utils/exceptions/firebase_exceptions.dart';
// import '../../../utils/exceptions/format_exceptions.dart';
// import '../../../utils/exceptions/platform_exceptions.dart';
//
// class AuthenticationRepository extends GetxController {
//   static AuthenticationRepository get instance => Get.find();
//
//   //
//   // //Variable //
//   // final _auth = FirebaseAuth.instance;
//   //
//   //
//   //
//   // // Register-User
//   //
//   // Future<UserCredential> registerWithEmailAndPassword (String email , String password) async {
//   //   try {
//   //     return await _auth.createUserWithEmailAndPassword(email: email, password: password);
//   //
//   //   } on FirebaseAuthException catch (e) {
//   //     throw MFirebaseAuthException(e.code).message;
//   //   } on FirebaseException catch (e) {
//   //     throw MFirebaseException(e.code).message;
//   //   } on FormatException catch(_) {
//   //     throw const MFormatException();
//   //   } on PlatformException catch(e) {
//   //     throw MPlatformException(e.code).message;
//   //   } catch(e){
//   //     throw 'Something went wrong. Please try again';
//   //   }
//   // }
//   //
//   // // Login-User
//   // Future<UserCredential> loginWithEmailAndPassword (String email , String password) async {
//   //   try {
//   //     return await _auth.signInWithEmailAndPassword(email: email, password: password);
//   //   } on FirebaseAuthException catch (e) {
//   //     throw MFirebaseAuthException(e.code).message;
//   //   } on FirebaseException catch (e) {
//   //     throw MFirebaseException(e.code).message;
//   //   } on FormatException catch(_) {
//   //     throw const MFormatException();
//   //   } on PlatformException catch(e) {
//   //     throw MPlatformException(e.code).message;
//   //   } catch(e){
//   //     throw 'Something went wrong. Please try again';
//   //   }
//   // }
//   //
//   // // Google-SignIn
//   //
//   // Future<UserCredential?> signInWithGoogle ()async {
//   //   try {
//   //     //trigger the authentication flow
//   //     final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
//   //
//   //     // obtain the auth details from request
//   //     final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
//   //
//   //     //create new credential
//   //     final credentials = GoogleAuthProvider.credential(
//   //         accessToken: googleAuth?.accessToken,
//   //         idToken: googleAuth?.idToken
//   //     );
//   //
//   //     //return credential when user sing in
//   //     return _auth.signInWithCredential(credentials);
//   //
//   //   } on FirebaseAuthException catch (e) {
//   //     throw MFirebaseAuthException(e.code).message;
//   //   } on FirebaseException catch (e) {
//   //     throw MFirebaseException(e.code).message;
//   //   } on FormatException catch(_) {
//   //     throw const MFormatException();
//   //   } on PlatformException catch(e) {
//   //     throw MPlatformException(e.code).message;
//   //   } catch(e){
//   //     print('Something went wrong. $e');
//   //     return null;
//   //   }
//   // }
//   //
//   // // Logout-User
//   //
//   // Future<void> logoutUser () async {
//   //   try {
//   //    //await GoogleSignIn().signOut();
//   //     await FirebaseAuth.instance.signOut();
//   //     Get.offAll((()=> const OnBoardingScreen()));
//   //   } on FirebaseAuthException catch (e) {
//   //     throw MFirebaseAuthException(e.code).message;
//   //   } on FirebaseException catch (e) {
//   //     throw MFirebaseException(e.code).message;
//   //   } on FormatException catch(_) {
//   //     throw const MFormatException();
//   //   } on PlatformException catch(e) {
//   //     throw MPlatformException(e.code).message;
//   //   } catch(e){
//   //     throw 'Something went wrong. Please try again';
//   //   }
//   // }
//
//   // Delete User Account
//   // Future<void> deleteAccount () async {
//   //   try {
//   //     await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
//   //     await _auth.currentUser?.delete();
//   //     Get.offAll((()=> LoginScreen()));
//   //   } on FirebaseAuthException catch (e) {
//   //     throw MFirebaseAuthException(e.code).message;
//   //   } on FirebaseException catch (e) {
//   //     throw MFirebaseException(e.code).message;
//   //   } on FormatException catch(_) {
//   //     throw const MFormatException();
//   //   } on PlatformException catch(e) {
//   //     throw MPlatformException(e.code).message;
//   //   } catch(e){
//   //     throw 'Something went wrong. Please try again';
//   //   }
//   // }
// }


