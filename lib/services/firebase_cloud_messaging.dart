import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseCloudMessaging {
  static Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
      providesAppNotificationSettings: true,
    );

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_messageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);

    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }
}

Future<void> _messageHandler(RemoteMessage message) async {
  debugPrint("${message.notification?.title}");
  debugPrint("${message.notification?.body}");
}
