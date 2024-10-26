import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
          title:  const Text('Favorites',
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
                  Lottie.asset('assets/lottie/empty.json',
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.4, // Adjust size based on height
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24), // Add spacing between sections
                  const Text(
                    'Nothing to see here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
