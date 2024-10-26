import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_personal_project/presentation/view/screens/onBoarding_screen/onboarding_screen.dart';
import 'package:my_personal_project/utils/custtom_button/custom_button.dart';

import '../../../../../data/controller/auth_controlller/verify_email_controller/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userPhotoUrl;

  const VerifyEmailScreen({super.key, required this.userName, required this.userEmail, required this.userPhotoUrl});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with username and email
    final controller = Get.put(VerifyEmailController(userName: userEmail, userPhotoUrl: ''));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:  const Text('E-Mail Verification',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
          ),
          actions: [
            IconButton(
              onPressed: (){
                Get.offAll(()=> const OnBoardingScreen());
              },
              icon: const Icon(CupertinoIcons.clear_thick),
            ),
          ],
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Lottie.asset('assets/lottie/verification.json',
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.width*0.8,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  const Text(
                    'We have sent you a verification email. Please check your inbox & verify to continue.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),
                  CustomElevatedButton(
                      onPressed: () => controller.checkEmailVerificationStatus(),
                      icon: CupertinoIcons.arrow_right,
                      label: 'Verify'
                  ),
                  const Spacer(),
                  TextButton(
                    iconAlignment: IconAlignment.start,
                    onPressed: ()=> controller.sendEmailVerification(),
                    child:  const Text('Resend E-Mail',
                      textAlign: TextAlign.left,),

                  ),
                  const Spacer(flex: 2,),

                ],
              ),
            ),
          ),
        )
    );


      Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
        centerTitle: true,
      ),
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'We have sent you a verification email. Please verify to continue.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            //Confirm Email Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.checkEmailVerificationStatus(),
                child: const Text("confirmEmail"),
              ),
            ),

            const SizedBox(height: 20,),

            //Resend Email Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: ()=> controller.sendEmailVerification(),
                child: const Text('resendEmail'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
