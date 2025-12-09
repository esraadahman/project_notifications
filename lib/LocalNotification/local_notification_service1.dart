import 'dart:developer';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService1 {
  // Android Setup (premetions)
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // need static function  onDidReceiveBackgroundNotificationResponse
  static onclick(NotificationResponse notificationResponse) {}
  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
        // this take android icon  from AndroidMainfest that in main
        android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings());

    // onDidReceiveBackgroundNotificationResponse =>(app in background) to when click notification navigate to specific location on app
    //    onDidReceiveNotificationResponse => to when click notification navigate to specific location on app
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: onclick,
      onDidReceiveNotificationResponse: onclick,
    );
  }

  // basic Notification
  static void showBasicNotification() async {
    // to make notification apper on top of app  => write this( importance: Importance.max, priority: Priority.high) and do clear for data in app
    NotificationDetails notificationDetails = const NotificationDetails(
        android: const AndroidNotificationDetails(
      "id 0",
      "basic notification",
      importance: Importance.max,
      priority: Priority.high,
    ));
    // show function contain (id => is int , title ,body , payload => message with notification )
    await flutterLocalNotificationsPlugin.show(
        0, "basic notification", "Body", notificationDetails,
        payload: "PayLoad Data");
  }

  // Repeated Notification
  static void showRepeatedNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 1',
      'repeated notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    AndroidScheduleMode androidScheduleMode = AndroidScheduleMode.alarmClock;

    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Reapated Notification',
      'body',
      RepeatInterval.everyMinute,
      details,
      payload: "Payload Data",
      androidScheduleMode: androidScheduleMode,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

// showSchduledNotification
  static void showSchduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 2',
      'repeated notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    AndroidScheduleMode androidScheduleMode = AndroidScheduleMode.alarmClock;

    // need to get time and location of device
    tz.initializeTimeZones();
    log(tz.TZDateTime.now(tz.local).hour.toString());
    log(tz.local.name);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'Schduled Notification',
        'body',
        // send notification after 10 seconds to click
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        tz.TZDateTime(tz.local, 2025 , 1 ,6,19 , 57),
        details,
        payload: "Payload Data",
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: androidScheduleMode);
  }
}
