import 'package:fantasy_cricket_app/assets/app_assets.dart';
import 'package:fantasy_cricket_app/screens/news_screen.dart';
import 'package:fantasy_cricket_app/screens/score_screen.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentScreen = 0;

  final List _listOfScreen = [
    ScoreScreen(),
    NewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _listOfScreen[_currentScreen],
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
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }
}
