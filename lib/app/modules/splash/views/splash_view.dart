import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffee4e2e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                'assets/splash.png',
                height: Get.height * 0.5,
              ),
            ),
            Text(
              'CLONING',
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
