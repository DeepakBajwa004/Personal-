import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_personal_project/presentation/view/screens/auth_screen/sign_in/widgets/RememberMeAndForgotPassword.dart';
import 'package:rive/rive.dart';
import '../../../../../data/controller/auth_controlller/sign_in_controller/sign_in_controller.dart';
import '../../../../../utils/custom_positioned/custom_positioned.dart';
import '../../../../../utils/custom_text_field/form_text_field.dart';
import '../../../../../utils/custtom_button/custom_button.dart';
import '../../../../../utils/validator/FormValidators.dart';
import '../forgot_password/forgot_password.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController _authController = Get.put(SignInController());
    return Stack(
      children: [
        Form(
          key: _authController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Email', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextField(
                  controller: _authController.emailController,
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email,
                  showSuffixIcon: false,
                  validator: FormValidators.validateEmail,
                ),
              ),
              const Text('Password', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextField(
                  controller: _authController.passwordController,
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock,
                  showSuffixIcon: true,
                  obscureText: true,
                  validator: (value) => FormValidators.validatePassword(value, minLength: 6),
                ),
              ),
              RememberMeAndForgotPassword(
                isChecked: _authController.isChecked.value,
                onRememberMeChanged: (value) => _authController.isChecked.value = value ?? false,
                onForgotPasswordPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return ForgotPasswordDialog();
                      }
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CustomElevatedButton(
                  onPressed: () {
                    _authController.signIn();
                  },
                  icon: CupertinoIcons.arrow_right,
                  label: 'Sign In',
                ),
              ),
            ],
          ),
        ),
        // Loading animation
        Obx(() {
          if (_authController.isShowLoading.value) {
            return CustomPositioned(
              child: RiveAnimation.asset(
                'assets/RiveAssets/check.riv', // Your loading Rive asset path
                onInit: (artboard) {
                  _authController.getRiveController(artboard);
                  // Optionally initialize any triggers if needed
                },
              ),
            );
          }
          return const SizedBox.shrink(); // Return an empty widget when not loading
        }),

        // Confetti animation
        Obx(() {
          if (_authController.isShowConfetti.value) {
            return CustomPositioned(
              child: Transform.scale(
                scale: 7,
                child: RiveAnimation.asset(
                  'assets/RiveAssets/confetti.riv',
                  onInit: (artboard) {
                     _authController.getRiveControllerr(artboard);
                  },
                ),
              ),
            );
          }
          return const SizedBox.shrink(); // Return an empty widget when not showing confetti
        }),
      ],
    );
  }
}
