import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/controller/auth_controlller/forgot_password_controller/forgot_password_controller.dart';
import '../../../../../utils/validator/FormValidators.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController =
  Get.put(ForgotPasswordController());
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Enter your email to receive a reset link.',),
      content:  Column(
        children: [
          const SizedBox(height: 10),
          CupertinoTextField(
            controller: emailController,
            placeholder: 'Email',
            padding: const EdgeInsets.all(10),
          ),
          const SizedBox(height: 10),

        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              String email = emailController.text.trim();
              if (FormValidators.validateEmail(email) == null) {
                forgotPasswordController
                    .sendPasswordResetEmail(email);
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
  }
}
