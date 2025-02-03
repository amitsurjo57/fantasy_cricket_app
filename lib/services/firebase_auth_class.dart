import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthClass {
  bool isUserNew = true;
  bool isPasswordStrong = true;
  bool isPasswordCorrect = true;
  bool isEmailValid = true;

  UserCredential? userCredential;

  Future<void> signUpUser(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential = credential;
      debugPrint("User Token ===> ${credential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isPasswordStrong = false;
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        isUserNew = false;
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logInUser(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      userCredential = credential;
      debugPrint("User Token ===> ${credential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        isEmailValid = false;
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        isPasswordCorrect = false;
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
