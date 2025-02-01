import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    // print notification token on terminal
    log(token ?? "null");
    // for background notification  , take a function as prameter
    FirebaseMessaging.onBackgroundMessage(handelBackGroundMessage);
  }

  static Future<void> handelBackGroundMessage(RemoteMessage message) async {
   await Firebase.initializeApp();
   log(message.notification?.title?? "null title");
  }
}
