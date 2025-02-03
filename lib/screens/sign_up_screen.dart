import 'package:fantasy_cricket_app/assets/app_assets.dart';
import 'package:fantasy_cricket_app/screens/home_screen.dart';
import 'package:fantasy_cricket_app/screens/log_in_screen.dart';
import 'package:fantasy_cricket_app/services/firebase_auth_class.dart';
import 'package:fantasy_cricket_app/services/user_auth.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                _appLogo(),
                _mainContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _mainContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      width: double.infinity,
      height: 400,
      color: Color(0xFF0D0639),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 28,
        children: [
          _textSignIn(),
          _emailField(),
          _passwordField(),
          _continueButton(),
          _logInNavigator(context)
        ],
      ),
    );
  }

  Image _appLogo() {
    return Image.asset(
      AppAssets.appLogo,
      width: 200,
    );
  }

  Row _logInNavigator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already Have an Account? ",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogInScreen(),
              ),
            );
          },
          child: Text(
            "Login Here",
            style: TextStyle(
              fontSize: 16,
              color: Colors.lightGreenAccent,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: Colors.lightGreenAccent,
            ),
          ),
        ),
      ],
    );
  }

  Visibility _continueButton() {
    return Visibility(
      visible: !_inProgress,
      replacement: Center(
        child: CircularProgressIndicator(
          color: Colors.lightGreenAccent,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
          onPressed: _onSignIn,
          color: Colors.lightGreenAccent,
          height: 48,
          child: Text(
            "Continue",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  SizedBox _passwordField() {
    return SizedBox(
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
    );
  }

  SizedBox _emailField() {
    return SizedBox(
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
    );
  }

  Text _textSignIn() {
    return Text(
      "Sign Up",
      style: TextStyle(
        fontSize: 32,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<void> _onSignIn() async {
    _inProgress = true;
    setState(() {});
    UserAuth userAuth = UserAuth();
    FirebaseAuthClass firebaseAuthClass = FirebaseAuthClass();

    await firebaseAuthClass.signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    await userAuth
        .saveUserToken(firebaseAuthClass.userCredential?.user?.uid ?? " ");

    _inProgress = false;
    setState(() {});

    if (firebaseAuthClass.isUserNew) {
      if (firebaseAuthClass.isPasswordStrong) {
        _navigateToHomeScreen();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Successfully Signed Up"),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Weak Password. Give a strong Password"),
            ),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email Already in Use"),
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
