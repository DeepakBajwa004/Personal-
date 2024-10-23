import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_personal_project/presentation/view/side_menu_screens/user_profile/widgets/custom_button.dart';
import 'package:my_personal_project/utils/images/image_strings.dart';

import '../../../../data/controller/auth_controlller/user_controller/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  final String userEmail;     // Declare userEmail
  final String userName;      // Declare userName
  final String userPhotoUrl;  // Declare userPhotoUrl

  const ProfileScreen({
    super.key,
    required this.userEmail,
    required this.userName,
    required this.userPhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 20,fontFamily: 'Poppins'),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.settings),
            onPressed: () {

            },
          ),
        ],
      ),
        body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0 ,vertical: 10),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 120, // Adjust size as needed
                height: 120, // Adjust size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Colors.blue,       // First color of the gradient
                      Colors.green,      // Second color of the gradient
                      Colors.lightBlue,  // Third color of the gradient
                    ],
                    stops: [0.0, 0.5, 1.0], // Control the gradient stops
                  ),
                  border: Border.all(
                    color: Colors.transparent, // Set border color to transparent
                    width: 4,                  // Border width
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent, // Make the background transparent
                  child: userPhotoUrl.isNotEmpty
                      ? ClipOval(
                    child: Image.network(
                      userPhotoUrl,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) {
                        // Return the asset image when there's an error loading the network image
                        return Image.asset(
                          defaultDp, // Your asset image path
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        );
                      },
                    ),
                  )
                      : Image.asset(
                    defaultDp, // Your asset image path
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Add spacing
            Text(
              userName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5), // Add spacing
            Text(
              userEmail,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
             const SizedBox(height: 20,),
            // ReusableButton(
            //   text: 'Edit Profile',
            //   color: Colors.green,
            //   textStyle:  const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            //   pressEvent: () {
            //    // Get.to(()=> EditProfileScreen(
            //    //   currentName: userName,
            //    //   currentPhotoUrl: userPhotoUrl,
            //    // ));
            //     // Add your logout logic here.
            //   },
            // ),
            const SizedBox(height: 20,),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ReusableButton(
                  text: 'Logout Account',
                  color: Colors.blue,
                  textStyle:  const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  pressEvent: () {
                    controller.showLogoutDialog(context);
                    // Add your logout logic here.
                  },
                ),

                ReusableButton(
                  text: 'Delete Account',
                  color: Colors.red,
                  textStyle:  const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  pressEvent: () {
                    controller.showAccountDeleteDialog(context);
                    // Add your delete account logic here.
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
