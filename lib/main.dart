import 'package:fantasy_cricket_app/screens/splash_screen.dart';
import 'package:fantasy_cricket_app/services/firebase_cloud_messaging.dart';
import 'package:fantasy_cricket_app/utils/app_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseCloudMessaging.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppUtils.primaryColor,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
        )
      ),
      home: const SplashScreen(),
    );
  }
}
