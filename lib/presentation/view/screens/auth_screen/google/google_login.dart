import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_personal_project/data/controller/auth_controlller/google_controller/google_controller.dart';
import 'package:my_personal_project/utils/custtom_button/custom_button.dart';
import 'package:my_personal_project/utils/images/image_strings.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GoogleController());
    return  Column(
      children: [
          IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: SvgPicture.asset(
            googleSvgIcon,
            color: const Color(0xFFF77D8E),
            height: 64,
            width: 64,
          ),
        ),
        const SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.only(top: 8.0 , bottom: 24),
          child: Obx(
            ()=> controller.isLoading.value
                ? LoadingAnimationWidget.dotsTriangle(
              size: 30,
              color: Colors.blue
            )
            :
            CustomElevatedButton(
              onPressed: () {
                controller.loginWithGoogle();
              },
              icon: CupertinoIcons.arrow_right,
              label: 'Login with Google',
            ),
          )
        ),
      ],
    );
  }
}
