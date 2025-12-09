import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_notifications/Copy/copyLink.dart';
import 'package:project_notifications/Copy/staticText.dart';
import 'package:project_notifications/Copy/textfiled_copy.dart';
import 'package:project_notifications/LocalNotification/local_notification_service1.dart';
import 'package:project_notifications/LocalNotification/test2.dart';
import 'package:project_notifications/PushFirebaseNotification/services/local_notification_service.dart';
import 'package:project_notifications/firebase_options.dart';
import 'package:project_notifications/PushFirebaseNotification/services/push_notifications_service.dart';
import 'package:project_notifications/PushFirebaseNotification/testApp.dart';
import 'package:project_notifications/shareOnGlopal/shareTest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // for Local NotificationServies

  await LocalNotificationService1.init();

  // for Push NotificationServies
  //*************
  // take the bigges time for method if method =5 and method2 =3 then it take => 5
  // Future.wait(
  //     [PushNotificationsService.init(), LocalNotificationService.init()]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:
            // copy
            //Statictext()
            // HomeScreen2()
            // for Push NotificationServies
            // Testapp()
            // for Local NotificationServies
            HomeScreen()
            //ShareTest()
            );
  }
}
