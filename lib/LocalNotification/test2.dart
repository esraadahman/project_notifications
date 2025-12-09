import 'package:flutter/material.dart';
import 'package:project_notifications/LocalNotification/local_notification_service1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        leading: const Icon(Icons.notifications),
        titleSpacing: 0.0,
        title: const Text('Flutter Local Notification Tutorial'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //basic
          ListTile(
            onTap: () {
              LocalNotificationService1.showBasicNotification();
            },
            leading: const Icon(Icons.notifications),
            title: const Text('Basic Notification'),
            subtitle: const Text('with custom sound'),
            trailing: IconButton(
              onPressed: () {
                LocalNotificationService1.cancelNotification(0);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          //repeated
          ListTile(
            onTap: () {
              LocalNotificationService1.showRepeatedNotification();
            },
            leading: const Icon(Icons.notifications),
            title: const Text('Repeated Notification'),
            subtitle: const Text('every minute'),
            trailing: IconButton(
              onPressed: () {
                LocalNotificationService1.cancelNotification(1);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          //Schduled
          ListTile(
            onTap: () {
                LocalNotificationService1.showSchduledNotification();
            },
            leading: const Icon(Icons.notifications),
            title: const Text('Schduled Notification'),
            subtitle: const Text('after 10 seconds from now'),
            trailing: IconButton(
              onPressed: () {
                LocalNotificationService1.cancelNotification(2);
              },
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
          ),
          //cancel All
          ElevatedButton(
            onPressed: () {
              //  LocalNotificationService.flutterLocalNotificationsPlugin
              //     .cancelAll();
            },
            child: const Text('Cancel All'),
          )
        ],
      )),
    );
  }
}
