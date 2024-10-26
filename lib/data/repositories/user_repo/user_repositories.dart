import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../models/user_model/UserModel.dart';

class UserRepositories {
  static UserRepositories get instance=>Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Method to save user data to Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      // Handle errors here (e.g., logging)
      print("Error saving user data: $e");
    }
  }


  // Fetch user details based on the current user
  Future<UserModel?> getUserDetails() async {
    try {
      // Get the currently signed-in user
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        // Check if user data exists
        if (userDoc.exists) {
          return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        } else {
          throw Exception('User data not found in Firestore');
        }
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null; // Handle errors appropriately in your app
    }
    return null; // Return null if user is not logged in
  }


}
