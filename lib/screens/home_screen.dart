import 'package:fantasy_cricket_app/assets/app_assets.dart';
import 'package:fantasy_cricket_app/screens/news_screen.dart';
import 'package:fantasy_cricket_app/screens/score_screen.dart';
import 'package:fantasy_cricket_app/screens/sign_up_screen.dart';
import 'package:fantasy_cricket_app/services/firebase_auth_class.dart';
import 'package:fantasy_cricket_app/services/user_auth.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentScreen = 0;
  bool _inDeleteProgress = false;
  bool _inUpdateProgress = false;
  bool _showPassword = false;
  final TextEditingController _passwordController = TextEditingController();

  final List _listOfScreen = [
    ScoreScreen(),
    NewsScreen(),
  ];

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _buildDrawer(),
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _listOfScreen[_currentScreen],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            _updatePasswordButton(),
            _deleteAccountButton(),
            _logOutButton(),
          ],
        ),
      ),
    );
  }

  SizedBox _logOutButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () async {
          await UserAuth().clearData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
              (_) => false,
            );
          }
        },
        label: Text("Log Out"),
        icon: Icon(Icons.logout_outlined),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue,
          iconColor: Colors.blue,
          textStyle: TextStyle(fontSize: 20),
          iconSize: 28,
        ),
      ),
    );
  }

  SizedBox _deleteAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Visibility(
        visible: !_inDeleteProgress,
        replacement: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        child: ElevatedButton.icon(
          onPressed: _onClickDelete,
          label: Text("Delete Account"),
          icon: Icon(Icons.delete),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red,
            iconColor: Colors.red,
            textStyle: TextStyle(fontSize: 20),
            iconSize: 28,
          ),
        ),
      ),
    );
  }

  SizedBox _updatePasswordButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: _onTapUpdatePasswordButton,
        label: Text("Update Password"),
        icon: Icon(Icons.lock),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.purpleAccent,
          iconColor: Colors.purpleAccent,
          textStyle: TextStyle(fontSize: 20),
          iconSize: 28,
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppUtils.primaryColor.withAlpha(200),
      iconSize: 24,
      selectedFontSize: 16,
      selectedIconTheme: IconThemeData(size: 32),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      selectedItemColor: AppUtils.loaderColor,
      unselectedItemColor: Colors.white,
      currentIndex: _currentScreen,
      onTap: (index) {
        setState(() {
          _currentScreen = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_cricket_outlined),
          label: 'Live Matches',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_outlined),
          label: 'News',
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppUtils.primaryColor,
      title: Image.asset(AppAssets.appLogo, width: 130),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  void _onTapUpdatePasswordButton() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: StatefulBuilder(
          builder: (context, setState) => Container(
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Enter New Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppUtils.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppUtils.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.redAccent.shade200,
                        fontSize: 14,
                      ),
                    ),
                    obscureText: _showPassword ? false : true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Password Can't be Empty";
                      } else if (_passwordController.text.length < 6) {
                        return "Password Should Contain at least 6 Character";
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _showPassword,
                      onChanged: (value) {
                        setState(() {
                          _showPassword = value!;
                        });
                      },
                      activeColor: AppUtils.primaryColor,
                    ),
                    Text("Show Password"),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: !_inUpdateProgress,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: _onClickUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppUtils.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Update"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onClickUpdate() async {
    FirebaseAuthClass firebaseAuthClass = FirebaseAuthClass();

    _inUpdateProgress = true;
    setState(() {});

    await firebaseAuthClass.updatePassword(
      password: _passwordController.text,
    );

    _inUpdateProgress = false;
    setState(() {});

    if (firebaseAuthClass.isSuccess!) {
      await UserAuth().clearData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(firebaseAuthClass.message!),
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
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(firebaseAuthClass.message!),
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

  Future<void> _onClickDelete() async {
    FirebaseAuthClass firebaseAuthClass = FirebaseAuthClass();

    _inDeleteProgress = true;
    setState(() {});

    await firebaseAuthClass.deleteAccount();

    _inDeleteProgress = false;
    setState(() {});

    if (firebaseAuthClass.isSuccess!) {
      await UserAuth().clearData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(firebaseAuthClass.message!),
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
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(firebaseAuthClass.message!),
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
}
