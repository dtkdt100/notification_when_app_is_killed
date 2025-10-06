import 'package:flutter/cupertino.dart';
import 'package:notification_when_app_is_killed/permissions/permissions.dart';

import 'model/args_for_kill_notification.dart';
import 'notification_when_app_is_killed_platform_interface.dart';

class NotificationWhenAppIsKilled {
  /// Setting up notification when app is killed
  ///
  /// [argsForKillNotification] : Arguments for notification
  /// Contains title, description, icon, and iOS specific arguments (interruptionLevel, useDefaultSound)
  ///
  /// Returns true if the notification is successfully set, false if permission is not granted, and null if there was an error.
  Future<bool?> setNotificationOnKillService(
      ArgsForKillNotification argsForKillNotification) async {
    if (await Permissions.requestNotificationPermissions() == false) {
      debugPrint('Notification permission is not granted');
      return false;
    }
    return NotificationWhenAppIsKilledPlatform.instance
        .setNotificationOnKillService(argsForKillNotification);
  }

  /// Cancels the notification set for when the app is killed.
  ///
  /// Returns true if the notification is successfully cancelled, and null if there was an error.
  Future<bool?> cancelNotificationOnKillService() async {
    return NotificationWhenAppIsKilledPlatform.instance
        .cancelNotificationOnKillService();
  }
}
