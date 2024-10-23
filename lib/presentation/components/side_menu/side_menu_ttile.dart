import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../data/models/rive_assets/rive_assets.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key, required this.menu, required this.press, required this.riveOnInit, required this.isActive,
  });

  final RiveAssets menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final bool isActive;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Divider(
            height: 1,
            color: Colors.white24 ,
          ),
        ),
        Stack(
          children: [
              AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              height: 56,
              curve: Curves.fastLinearToSlowEaseIn,
              width: isActive  ? 295 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6792FF),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src ,
                  artboard: menu.artboard,
                  onInit: riveOnInit,
                ),
              ),
              title:  Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
