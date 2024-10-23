import 'dart:ui'; // Needed for ImageFilter
import 'package:flutter/material.dart' as flutter; // Prefix Flutter's Image
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/animated_btn.dart';
import '../auth_screen/custom_auth_dialog.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  bool isSignInDialogShown =false;
  late RiveAnimationController _btnAnimationController ;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
        "active",
      autoplay: false
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned(
              bottom: 200,
              left: 100,
              width: MediaQuery.of(context).size.width*1.7,
              child: flutter.Image.asset( 'assets/Backgrounds/Spline.png', )
          ),

          // Blurred Background using BackdropFilter
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
            ),
          ),
          // Rive Animation Overlay
          const RiveAnimation.asset( 'assets/RiveAssets/shapes.riv', ),

          // Blurred Background using BackdropFilter
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(), // Transparent widget for the blur effect
            ),
          ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 240) ,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              top: isSignInDialogShown ? -50 : 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const SizedBox(
                        width: 260,
                        child: Column(
                          children: [
                            Text("Let's Enjoyy",
                                 style: TextStyle( fontSize: 50,  fontFamily: 'Poppins',  height: 1.2  ),
                            ),
                             SizedBox(height: 16),
                            Text(
                              "सपनों की दुनिया में तेरा ही साया है,\n"
                                  "जुदाई के ग़म में भी तेरा नाम साया है।",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 2,),
                      AnimatedBtn(
                        btnAnimationController: _btnAnimationController,
                        press: () async {
                          _btnAnimationController.isActive = true;

                          // Wait for animation to finish before showing the dialog
                          await Future.delayed(const Duration(milliseconds: 800));

                          if (mounted) {
                            setState(() {
                              isSignInDialogShown = true;
                            });

                            customSignInDialog(
                              context,
                              onClosed: (_) {
                                if (mounted) {
                                  setState(() {
                                    isSignInDialogShown = false;
                                  });
                                }
                              },
                            );
                          }
                        },
                      ),
                      const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child:  Text(
                      "सपनों की दुनिया में तेरा ही साया है,\n"
                          "जुदाई के ग़म में भी तेरा नाम साया है।",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                    ],
                  ),
                )
                        ),
            )

        ],
      ),
    );
  }
}




