import 'package:email_validator/email_validator.dart';
import 'package:fantasy_cricket_app/assets/app_assets.dart';
import 'package:fantasy_cricket_app/screens/sign_up_screen.dart';
import 'package:fantasy_cricket_app/services/firebase_auth_class.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _inProgress = false;

  @override
  void dispose() {
    _emailController.dispose();
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
      height: 200,
      color: Color(0xFF0D0639),
      child: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              _emailField(),
              _continueButton(),
            ],
          ),
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
          onPressed: _onContinue,
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

  Image _appLogo() {
    return Image.asset(
      AppAssets.appLogo,
      width: 200,
    );
  }

  Future<void> _onContinue() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    }

    _inProgress = true;
    setState(() {});

    await FirebaseAuthClass().resetPassword(
      email: _emailController.text,
    );

    _inProgress = false;
    setState(() {});

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("A Link is Sent to Your Email"),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        ),
        (_) => false,
      );
    }
  }
}
