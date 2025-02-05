import 'package:email_validator/email_validator.dart';
import 'package:fantasy_cricket_app/assets/app_assets.dart';
import 'package:fantasy_cricket_app/screens/home_screen.dart';
import 'package:fantasy_cricket_app/screens/password_reset_screen.dart';
import 'package:fantasy_cricket_app/services/firebase_auth_class.dart';
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
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _inProgress = false;
  bool _isObscured = true;

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
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _appLogo(),
                _mainContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _mainContent() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      width: double.infinity,
      height: 360,
      color: Color(0xFF0D0639),
      child: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              _textLogIn(),
              _emailField(),
              _passwordField(),
              _forgetPassword(),
              _continueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Align _forgetPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordResetScreen(),
            ),
          );
        },
        child: const Text(
          "Forget Password?",
          style: TextStyle(
              color: Colors.lightGreenAccent,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
      ),
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
          onPressed: _onLogin,
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
      child: TextFormField(
        controller: _passwordController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: 'Enter Password',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            child: _isObscured
                ? Icon(Icons.visibility)
                : Icon(
              Icons.visibility_off,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(
            color: Colors.redAccent.shade200,
            fontSize: 14,
          ),
        ),
        obscureText: _isObscured,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Password Can't be Empty";
          }
          return null;
        },
      ),
    );
  }

  SizedBox _emailField() {
    return SizedBox(
      child: TextFormField(
        controller: _emailController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
          hintText: 'Enter Your Email',
          errorStyle: TextStyle(
            color: Colors.redAccent.shade200,
            fontSize: 14,
          ),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Email Can't be Empty";
          } else if (!EmailValidator.validate(_emailController.text)) {
            return "Invalid Email";
          }
          return null;
        },
      ),
    );
  }

  Text _textLogIn() {
    return Text(
      "Log in",
      style: TextStyle(
        fontSize: 32,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Image _appLogo() {
    return Image.asset(
      AppAssets.appLogo,
      width: 200,
    );
  }

  Future<void> _onLogin() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    }

    _inProgress = true;
    setState(() {});
    FirebaseAuthClass firebaseAuthClass = FirebaseAuthClass();

    await firebaseAuthClass.logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    _inProgress = false;
    setState(() {});

    if (firebaseAuthClass.isSuccess!) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (_) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(firebaseAuthClass.message!),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(firebaseAuthClass.message!),
          ),
        );
      }
    }
  }
}
