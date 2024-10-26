import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
        ),
        title: const Text(
          'Help',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Lottie Animation with dynamic size
              Lottie.asset(
                'assets/lottie/help.json',
                width: screenWidth * 0.8,
                height: screenHeight * 0.4, // Adjust size based on height
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24), // Add spacing between sections

              // Descriptive text
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
              const SizedBox(height: 24), // Spacing between sections

              // Help message
              const Text(
                'Need Help? We are here for you!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Contact Information
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

              // Selectable Email
              const SelectableText(
                'support@ourapp.com',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
