
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    super.key, required this.press, required this.riveOnInit,
  });

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(left: 16),
          decoration:  const BoxDecoration(
              color: Color(0xFF6792FF),
              shape: BoxShape.circle,
              boxShadow: [ BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0,3),
                  blurRadius: 3
              )]
          ),
          child: RiveAnimation.asset(
            'assets/RiveAssets/menu_button.riv',
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}


