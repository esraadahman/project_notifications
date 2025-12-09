import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    // log(notificationResponse.id!.toString());
    // log(notificationResponse.payload!.toString());
    streamController.add(notificationResponse);
    // Navigator.push(context, route);
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  //basic Notification
  static void showBasicNotification(RemoteMessage message) async {
    // show image in notification that is url not local
    final http.Response image = await http
        .get(Uri.parse(message.notification?.android?.imageUrl ?? ''));
    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      ByteArrayAndroidBitmap.fromBase64String(
        base64Encode(image.bodyBytes),
      ),
      largeIcon: ByteArrayAndroidBitmap.fromBase64String(
        base64Encode(image.bodyBytes),
      ),
    );
    AndroidNotificationDetails android = AndroidNotificationDetails(
      // 'id 2',
      // 'repeated notification',   => updates for sound
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
      // for sound
      playSound: true,
      // Add the sound file to android/app/src/main/res/raw/
      sound: RawResourceAndroidNotificationSound(
          'notification_9_158194'.split('.').first),
    );
    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
      //  payload: "Payload Data",
    );
  }

  // to change request for api you need to add this part
  /**your api request before 
   * {
    "message":{
        "token":"cVNbRbN2SaOLPxp4M4VlK1:APA91bGD2Emj-1Qo11BwZzmAkU6LOD_C_5Ze83jULwmxB7OM-4J69XeDI8MqbguQEixovx1bYlv0gnVA4AsyT_HQa_yfzHz0blaDGCRkZ0pIjpuwdrFLBvs",
        "notification":{
            "title":"title image",
            "body":"new body",
            "image":"https://images.unsplash.com/photo-1452457750107-cd084dce177d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y29tcHV0ZXIlMjBzY2llbnNlfGVufDB8fDB8fHww"
        }
  
    }
}    so add this =>  ||
   * 
   * 
   *     "android": {
    "notification": {
        "channel_id": "channel_id" // NOTIFICATION CHANNEL ID WITH CUSTOM SOUND REFERENCE HERE
    }

   */
}

/** to add sound you need 
 * 1-  Add the sound file to android/app/src/main/res/raw/
 * 2- Add this part in code (  sound: RawResourceAndroidNotificationSound(
          'notification-9-158194'.split('.').first),)
   3- change api request (
   Add =>   "android": {
    "notification": {
        "channel_id": "channel_id" // NOTIFICATION CHANNEL ID WITH CUSTOM SOUND REFERENCE HERE
     }
   )
  4- Add Kotline \android\app\src\main\kotlin\com\example\name of project\
  (take code copy from here , change name of project)
  
  5- update mainActivity  by add this code (
   override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Notifications.createNotificationChannels(this)
    }
  )

  6- (
    1- you have the correct Kotlin version in android/build.gradle:

    ext.kotlin_version = '1.7.10' // or latest compatible version
    dependencies {
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
    2- The Kotlin plugin is applied in android/app/build.gradle:

    apply plugin: 'kotlin-android'
)

 */
