import 'package:get/get.dart';

class AnimatedTextController extends GetxController {
  var scale = 1.0.obs; // Observable variable to track the scale

  void animateText() {
    scale.value = 1.2; // Enlarge the text
    Future.delayed(const Duration(milliseconds: 200), () {
      scale.value = 1.0; // Reset the text to normal size
    });
  }
}
