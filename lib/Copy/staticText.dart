import 'package:flutter/material.dart';
import 'package:project_notifications/Copy/copyLink.dart';

class Statictext extends StatelessWidget {
  const Statictext({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
          body: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("esraa"),
              CopyLinkButton(
             text: "esraa", 
              ),
            ],
          ),
        );
  }
}