import 'dart:async';
import 'package:fantasy_cricket_app/assets/app_assets.dart';
import 'package:fantasy_cricket_app/screens/home_screen.dart';
import 'package:fantasy_cricket_app/screens/sign_up_screen.dart';
import 'package:fantasy_cricket_app/services/user_auth.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () async {
        if (await UserAuth().isLoggedIn()) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        } else {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            );
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(AppAssets.splashScreenImage),
        Positioned(
          top: 600,
          left: 170,
          child: CircularProgressIndicator(
            color: AppUtils.loaderColor,
          ),
        ),
      ],
    );
  }
}
