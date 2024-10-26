import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_personal_project/presentation/view/screens/auth_screen/google/google_login.dart';
import 'package:my_personal_project/presentation/view/screens/auth_screen/phone/phone.dart';
import 'package:my_personal_project/presentation/view/screens/auth_screen/sign_in/sign_in_form.dart';
import 'package:my_personal_project/presentation/view/screens/auth_screen/sign_up/sign_up_form.dart';
import 'package:my_personal_project/utils/images/image_strings.dart';

Future<Object?> customSignInDialog(
    BuildContext context, {required ValueChanged onClosed}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  // A variable to track which login type to show
  String selectedMethod = 'signup'; // Default to Sign Up

  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: 'Sign In',
    transitionDuration: const Duration(milliseconds: 700),
    transitionBuilder: (_, animation, __, child) {
      final tween = Tween(begin: const Offset(0.7, -1.2), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    context: context,
    pageBuilder: (context, _, __) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: Container(
              width: screenWidth * 0.90,    // Responsive width
              height: screenHeight * 0.8 +20,
               margin: const EdgeInsets.symmetric(horizontal: 12),
               padding: const EdgeInsets.only(left: 22, right: 30,top: 15,bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.94),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.8,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  selectedMethod == 'signup'
                                      ? 'Create Account'
                                      : selectedMethod == 'login'
                                      ? 'Login With Email'
                                      : selectedMethod == 'phone'
                                      ? 'Login With Phone'
                                      : 'Login With Google',
                                  style: const TextStyle(
                                      fontSize: 32, fontFamily: 'Poppins'),
                                ),
                              ),
                              const Spacer(),
                              // Show different forms based on the selected method
                              if (selectedMethod == 'signup') const SignUpForm(), // Use your sign-up form here
                              if (selectedMethod == 'login') const SignInForm(),
                              if (selectedMethod == 'phone') const PhoneForm(),
                              if (selectedMethod == 'google')  const GoogleLogin(),
                              const Spacer(),
                              const Row(
                                children: [
                                  Expanded(child: Divider()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      'OR',
                                      style: TextStyle(color: Colors.black26),
                                    ),
                                  ),
                                  Expanded(child: Divider()),
                                ],
                              ),
                               Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    selectedMethod == 'signup'
                                        ? 'Login with Email, Google or Phone'
                                        : 'Sign Up with Email, Google or Phone',
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                ),
                              ),
                          
                              // Icons to switch between login methods
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // First option: Sign Up
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        // Toggle between 'login' and 'signup'
                                        selectedMethod = selectedMethod == 'login' ? 'signup' : 'login';
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      emailSvgIcon,
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                  // Second option: Google Login
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        selectedMethod = 'google'; // Set to google login
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      googleSvgIcon,
                                      color: const Color(0xFFF77D8E),
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                  // Third option: Phone Login
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        selectedMethod = 'phone'; // Set to phone login
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      phoneSvgIcon,
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -48,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  ).then(onClosed);
}
