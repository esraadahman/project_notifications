import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:project_notifications/PushFirebaseNotification/services/local_notification_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async {
    await messaging.requestPermission();
    // get token from devise and send it to backend
    String? token = await messaging.getToken().then((value) {
      sendTokenToServer(value!);
    });
    // to if device token change still send the new one to back
    // messaging.onTokenRefresh.listen(
    //   (value) {
    //     sendTokenToServer(value);
    //   },
    // );
    // print notification token on terminal
    log(token ?? "null");
    // for background notification  , take a function as prameter
    // this work in background or in killed
    FirebaseMessaging.onBackgroundMessage(handelBackGroundMessage);
    // this for foreground notifications
    handleForeGroundMessage();
    // to make topic (group for more than one user)
    messaging.subscribeToTopic("all").then((value) {
      log("sub to all");
    });
    // when logout from topic we use
    //messaging.unsubscribeFromTopic("all");
  }

  // for background notification
  static Future<void> handelBackGroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? "null title");
  }

// this for foreground notifications
  static void handleForeGroundMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       // it not handle it to apper in notification bar so we use local notification 
    //  print("FOREGROUND MESSAGE: ${message.notification?.title}");
      // show local notification
      LocalNotificationService.showBasicNotification(message);
    });
  }

  static void sendTokenToServer(String token) {
    // option one => to send token Api
    // option tow => to send token firbase
  }
}
