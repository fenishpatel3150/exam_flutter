import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../login/LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
          () {
        Get.to(LoginScreen());
      },
    );
    return Scaffold(
      backgroundColor: Color(0xfff6e24b),
      body: Column(
        children: [
          Image(image: AssetImage('assets/image/splash.jpg'))
        ],
      ),
    );
  }
}
