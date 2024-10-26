import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/controller/animated_text_controller/animated_text_controller.dart';

class AnimatedText extends StatelessWidget {
  final String text; // The text to display
  final TextStyle? style; // Optional custom style

  AnimatedText({super.key, required this.text, this.style});

  // Access the controller
  final AnimatedTextController _controller = Get.put(AnimatedTextController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _controller.animateText, // Trigger animation on tap
      child: Obx(() => Transform.scale(
        scale: _controller.scale.value, // Use the scale value from the controller
        child: Text(
          text,
          style: style ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
