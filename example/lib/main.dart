import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:notification_when_app_is_killed/model/args_for_ios.dart';
import 'package:notification_when_app_is_killed/model/args_for_kill_notification.dart';
import 'package:notification_when_app_is_killed/notification_when_app_is_killed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isServiceOn = false;
  final _notificationWhenAppIsKilledPlugin = NotificationWhenAppIsKilled();

  Future<void> setNotificationOnKill() async {
    bool success;
    try {
      ArgsForIos argsForIos = ArgsForIos(
        interruptionLevel: InterruptionLevel.critical,
        useDefaultSound: true,
      );
      success =
          await _notificationWhenAppIsKilledPlugin.setNotificationOnKillService(
                ArgsForKillNotification(
                    title: 'The app is killed',
                    description:
                        'You can see this notification when the app is killed',
                    androidIcon: '@raw/ic_launcher',
                    argsForIos: argsForIos),
              ) ??
              false;
    } on PlatformException {
      success = false;
    }
    if (!success) return;
    setState(() {
      _isServiceOn = true;
    });
  }

  Future<void> cancelNotificationOnKill() async {
    bool success;
    try {
      success = await _notificationWhenAppIsKilledPlugin
              .cancelNotificationOnKillService() ??
          false;
    } on PlatformException {
      success = false;
    }
    if (!success) return;
    setState(() {
      _isServiceOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification when app is killed example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: setNotificationOnKill,
                  child: const Text('Set notification when app is killed')),
              TextButton(
                  onPressed: cancelNotificationOnKill,
                  child: const Text('Cancel notification when app is killed')),
              const SizedBox(height: 20),
              Text('Service is on: '),
              Switch(
                  value: _isServiceOn,
                  onChanged: (value) {
                    if (value) {
                      setNotificationOnKill();
                    } else {
                      cancelNotificationOnKill();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
