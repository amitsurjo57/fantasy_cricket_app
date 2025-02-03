import 'package:fantasy_cricket_app/assets/app_assets.dart';
import 'package:fantasy_cricket_app/screens/home_screen.dart';
import 'package:fantasy_cricket_app/services/firebase_auth_class.dart';
import 'package:fantasy_cricket_app/services/user_auth.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _inProgress = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              AppUtils.primaryColor,
              Colors.black,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0, 0.5, 1],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.appLogo,
                  width: 200,
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  width: double.infinity,
                  height: 400,
                  color: Color(0xFF0D0639),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 40,
                    children: [
                      Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity - 60,
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Enter Your Email',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity - 60,
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          obscureText: true,
                        ),
                      ),
                      Visibility(
                        visible: !_inProgress,
                        replacement: Center(
                          child: CircularProgressIndicator(
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: _onLogin,
                            color: Colors.lightGreenAccent,
                            height: 48,
                            child: Text(
                              "Continue",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLogin() async {
    _inProgress = true;
    setState(() {});
    FirebaseAuthClass firebaseAuthClass = FirebaseAuthClass();
    UserAuth userAuth = UserAuth();

    await firebaseAuthClass.logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    await userAuth
        .saveUserToken(firebaseAuthClass.userCredential?.user?.uid ?? " ");

    _inProgress = false;
    setState(() {});

    if (firebaseAuthClass.isEmailValid) {
      if (firebaseAuthClass.isPasswordCorrect) {
        _navigateToHomeScreen();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Successfully Logged In"),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Wrong Password"),
            ),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No user found for that email."),
          ),
        );
      }
    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
      (_) => false,
    );
  }
}
