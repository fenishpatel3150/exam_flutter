import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices {
  GoogleAuthServices._();
  static final GoogleAuthServices googleAuthServices = GoogleAuthServices._();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        Get.snackbar("Sign in Cancelled", "User cancelled Google Sign-in.");
        return 'Cancelled';
      }

      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      log("Sign-in successful: ${userCredential.user?.email}");

      Get.snackbar("Sign in Success", "Welcome, ${userCredential.user?.displayName}");
      return 'Success';
    } catch (e) {
      log(e.toString());

      if (e is FirebaseAuthException) {
        Get.snackbar("Firebase Auth Failed", e.message ?? 'Unknown error');
      } else {
        Get.snackbar("Google Sign in Failed", e.toString());
      }

      return 'Failed';
    }
  }

  User? currentUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
      Get.snackbar("Sign out", "User signed out successfully.");
    } catch (e) {
      log("Sign out error: $e");
      Get.snackbar("Sign out Failed", e.toString());
    }
  }
}
