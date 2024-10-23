import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(CupertinoIcons.back),
          ),
          title:  const Text('About us',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Spacer(),
                  Lottie.asset('assets/lottie/about_us.json',
                    width: MediaQuery.of(context).size.width*1,
                    height: MediaQuery.of(context).size.width*1,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  const Text(
                    'Our app is designed to provide you with the best experience. '
                        'We aim to make your life easier, more organized, and enjoyable. '
                        'Stay tuned for exciting updates and new features!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 2,),
                ],
              ),
            ),
          ),
        )
    );
  }
}
