import 'package:flutter/cupertino.dart';
import 'package:notification_when_app_is_killed/permissions/permissions.dart';

import 'model/args_for_kill_notification.dart';
import 'notification_when_app_is_killed_platform_interface.dart';

class NotificationWhenAppIsKilled {
  Future<bool?> setNotificationOnKillService(
      ArgsForKillNotification argsForKillNotification) async {
    if (await Permissions.requestNotificationPermissions() == false) {
      debugPrint('Notification permission is not granted');
      return false;
    }
    return NotificationWhenAppIsKilledPlatform.instance
        .setNotificationOnKillService(argsForKillNotification);
  }

  Future<bool?> cancelNotificationOnKillService() async {
    return NotificationWhenAppIsKilledPlatform.instance
        .cancelNotificationOnKillService();
  }
}
