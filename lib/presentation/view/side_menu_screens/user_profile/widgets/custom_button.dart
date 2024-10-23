import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final VoidCallback pressEvent;
  final TextStyle? textStyle;

  const ReusableButton({
    super.key,
    required this.text,
    required this.color,
    required this.pressEvent,
    this.height = 50,
    this.width = 150,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.textStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: height,
      width: width,
      borderRadius: borderRadius,
      text: text,
      buttonTextStyle: textStyle ?? Theme.of(context).textTheme.labelLarge!,
      color: color,
      pressEvent: pressEvent,
    );
  }
}
