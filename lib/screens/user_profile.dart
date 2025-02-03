import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final UserCredential userCredential;
  const UserProfile({super.key, required this.userCredential});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  void initState() {
    debugPrint("${widget.userCredential.user?.displayName}");
    debugPrint("${widget.userCredential.user?.photoURL}");
    debugPrint("${widget.userCredential.user?.email}");
    debugPrint("${widget.userCredential.user?.phoneNumber}");
    debugPrint("${widget.userCredential.user?.providerData}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
