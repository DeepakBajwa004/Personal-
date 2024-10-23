
import 'package:flutter/material.dart';

class CustomPositioned extends StatelessWidget {
  final Widget child;
  final double size;

  const CustomPositioned({super.key, required this.child, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(height: size, width: size, child: child),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
