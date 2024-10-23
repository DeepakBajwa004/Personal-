import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import '../../../../../data/controller/auth_controlller/sign_up_controller/sign_up_conntroller.dart';
import '../../../../../utils/custom_positioned/custom_positioned.dart';
import '../../../../../utils/custom_text_field/form_text_field.dart';
import '../../../../../utils/custtom_button/custom_button.dart';
import '../../../../../utils/validator/FormValidators.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());

    return Stack(
      children: [
        Form(
          key: signUpController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Username', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: CustomTextField(
                  controller: signUpController.usernameController,
                  hintText: 'Enter your username',
                  prefixIcon: Icons.person,
                  validator: (value) => FormValidators.validateName(value),
                ),
              ),
              const Text('Email', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: CustomTextField(
                  controller: signUpController.emailController,
                  hintText: 'Please enter your email',
                  prefixIcon: Icons.email,
                  validator: FormValidators.validateEmail,
                ),
              ),
              const Text('Password', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: CustomTextField(
                  controller: signUpController.passwordController,
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  showSuffixIcon: true,
                  validator: (value) => FormValidators.validatePassword(value, minLength: 6),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                child: CustomElevatedButton(
                  onPressed: () {
                    signUpController.signUp();
                  },
                  icon: Icons.arrow_forward,
                  label: 'Sign Up',
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (signUpController.isShowLoading.value) {
            return CustomPositioned(
              child: RiveAnimation.asset(
                'assets/RiveAssets/check.riv',
                onInit: (artboard) {
                   signUpController.getRiveController(artboard);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        }),
        Obx(() {
          if (signUpController.isShowConfetti.value) {
            return CustomPositioned(
              child: Transform.scale(
                scale: 7,
                child: RiveAnimation.asset(
                  'assets/RiveAssets/confetti.riv',
                  onInit: (artboard) {
                    signUpController.getRiveControllerr(artboard);
                  },
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}

