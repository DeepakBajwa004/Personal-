import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
          title:  const Text('Help',
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
                  Lottie.asset('assets/lottie/help.json',
                    width: MediaQuery.of(context).size.width*1,
                    height: MediaQuery.of(context).size.width*1,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  const Text(
                    'We aim to provide you with the best experience through '
                        'our innovative features. Our goal is to make your life easier, '
                        'organized, and enjoyable. Stay tuned for updates!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Spacer(),
                  const Text(
                    'Need Help? We are here for you!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Spacer(),
                  const Text(
                    'If you have any questions or need assistance, feel free to '
                        'reach out to us at:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const SelectableText(
                    'support@ourapp.com',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
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
