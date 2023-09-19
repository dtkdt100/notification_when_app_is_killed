import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'model/args_for_kill_notification.dart';
import 'notification_when_app_is_killed_platform_interface.dart';

/// An implementation of [NotificationWhenAppIsKilledPlatform] that uses method channels.
class MethodChannelNotificationWhenAppIsKilled
    extends NotificationWhenAppIsKilledPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('notification_when_app_is_killed');

  @override
  Future<bool?> setNotificationOnKillService(
      ArgsForKillNotification argsForKillNotification) async {
    final success = await methodChannel.invokeMethod<bool>(
        'setNotificationOnKillService', argsForKillNotification.toJson());
    debugPrint('setNotificationOnKillService: $success');
    return success;
  }

  @override
  Future<bool?> cancelNotificationOnKillService() async {
    final success = await methodChannel
        .invokeMethod<bool>('cancelNotificationOnKillService');
    debugPrint('cancelNotificationOnKillService: $success');
    return success;
  }
}
