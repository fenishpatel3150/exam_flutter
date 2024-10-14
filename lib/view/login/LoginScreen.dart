import 'package:exam_flutter/firebase/authentication.dart';
import 'package:exam_flutter/view/home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.h),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email Id',
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h, right: 20.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () async {
                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    Get.snackbar('Error', 'Please fill in all fields',
                        snackPosition: SnackPosition.BOTTOM);
                    return;
                  }
                  // Show loading indicator
                  Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
                  try {
                    final userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    Get.back(); // Close loading indicator
                    Get.to(() => HomeScreen());
                  } catch (e) {
                    Get.back(); // Close loading indicator
                    if (e is FirebaseAuthException) {
                      Get.snackbar('Authentication Error', e.message ?? 'Unknown error',
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      Get.snackbar('Error', e.toString(),
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  }
                },
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Color(0xfff6e24b),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Colors.white, fontSize: 15.h),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  'Or',
                  style: TextStyle(color: Colors.black, fontSize: 15.h),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String result = await GoogleAuthServices.googleAuthServices.signInWithGoogle();
                      if (result == 'Success') {
                        Get.to(HomeScreen());
                      } else {
                        Get.snackbar("Error", "Google Sign-in failed");
                      }
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/logo.jpeg')),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/apple.jpg')),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/facebook.jpg')),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    " Sign Up",
                    style: TextStyle(color: Color(0xfff6e24b), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
