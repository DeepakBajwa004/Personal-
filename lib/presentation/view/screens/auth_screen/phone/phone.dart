import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_personal_project/data/controller/auth_controlller/phone_controller/phone_controller.dart';
import 'package:rive/rive.dart';
import '../../../../../data/controller/auth_controlller/sign_up_controller/sign_up_conntroller.dart';
import '../../../../../utils/custom_positioned/custom_positioned.dart';
import '../../../../../utils/custom_text_field/form_text_field.dart';
import '../../../../../utils/custtom_button/custom_button.dart';
import '../../../../../utils/validator/FormValidators.dart';

class PhoneForm extends StatelessWidget {
  const PhoneForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneController());

    return Stack(
      children: [
        Form(
           key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Username', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: CustomTextField(
                  controller: controller.usernameController,
                  hintText: 'Enter your username',
                  prefixIcon: Icons.person,
                  validator: (value) => FormValidators.validateName(value),
                ),
              ),
              const Text('Number', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: CustomTextField(
                  controller: controller.phoneController,
                  hintText: 'Please enter your Number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.number,
                  validator:(value) =>  FormValidators.validatePhoneNumber(value),
                ),
              ),
              const Text('Password', style: TextStyle(color: Colors.black54)),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: CustomTextField(
                  controller: controller.otpController,
                  hintText: 'Enter your OTP',
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.number,
                  validator: (value) => FormValidators.validateOtp(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                child: CustomElevatedButton(
                  onPressed: () {
                    controller.loginWithPhone();
                  },
                  icon: Icons.arrow_forward,
                  label: 'Sign Up with Phone',
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.isShowLoading.value) {
            return CustomPositioned(
              child: RiveAnimation.asset(
                'assets/RiveAssets/check.riv',
                onInit: (artboard) {
                  controller.getRiveController(artboard);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        }),
        Obx(() {
          if (controller.isShowConfetti.value) {
            return CustomPositioned(
              child: Transform.scale(
                scale: 7,
                child: RiveAnimation.asset(
                  'assets/RiveAssets/confetti.riv',
                  onInit: (artboard) {
                    controller.getRiveController(artboard);
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

