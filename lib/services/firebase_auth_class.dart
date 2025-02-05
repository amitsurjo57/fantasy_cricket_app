import 'package:fantasy_cricket_app/services/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthClass {
  bool? isSuccess;
  String? message;
  bool inProgress = true;

  Future<void> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      UserAuth userAuth = UserAuth();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint("User Token ===> ${credential.user?.uid}");
      await userAuth.saveUserToken(credential.user?.uid);
      isSuccess = true;
      inProgress = false;
      message = "Successfully Signed up";
    } on FirebaseAuthException catch (e) {
      isSuccess = false;
      if (e.code == 'weak-password') {
        message = "Weak Password. Please give a strong password";
      } else if (e.code == 'email-already-in-use') {
        message = "Email Already in Use";
      }
      debugPrint(message);
    } catch (e) {
      message = e.toString();
      debugPrint(e.toString());
    }
  }

  Future<void> logInUser({
    required String email,
    required String password,
  }) async {
    try {
      UserAuth userAuth = UserAuth();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint("User Token ===> ${credential.user?.uid}");
      await userAuth.saveUserToken(credential.user?.uid);
      isSuccess = true;
      inProgress = false;
      message = "Successfully Logged in";
    } on FirebaseAuthException catch (_) {
      isSuccess = false;
      inProgress = true;
      message = "Email or Password is Incorrect";
      debugPrint(message);
    }
  }

  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<void> deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      isSuccess = true;
      message = "Account Deleted Successfully.";
      debugPrint("Account Deleted Successfully.");
    } on FirebaseAuthException catch (e) {
      isSuccess = false;
      if (e.code == "requires-recent-login") {
        message = "You Have to Login Again to Delete Your Account";
        debugPrint("You Have to Login Again to Delete Your Account");
      } else {
        message = "Something Went Wrong";
        debugPrint("Something Went Wrong ==> ${e.toString()}");
      }
    } catch (e) {
      isSuccess = false;
      message = "Something Went Wrong";
      debugPrint("Something Went Wrong ==> ${e.toString()}");
    }
  }

  Future<void> updatePassword({required String password}) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(password);
      isSuccess = true;
      message = "Password Updated Successfully.";
      debugPrint("Password Updated Successfully.");
    } on FirebaseAuthException catch (e) {
      isSuccess = false;
      if (e.code == "requires-recent-login") {
        message = "You Have to Login Again to Update Your Password";
        debugPrint("You Have to Login Again to Update Your Password");
      } else {
        message = "Something Went Wrong";
        debugPrint("Something Went Wrong ==> ${e.toString()}");
      }
    } catch (e) {
      isSuccess = false;
      message = "Something Went Wrong";
      debugPrint("Something Went Wrong ==> ${e.toString()}");
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
