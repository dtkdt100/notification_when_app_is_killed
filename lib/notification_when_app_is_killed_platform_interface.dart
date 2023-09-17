import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'model/args_for_kill_notification.dart';
import 'notification_when_app_is_killed_method_channel.dart';

abstract class NotificationWhenAppIsKilledPlatform extends PlatformInterface {
  /// Constructs a NotificationWhenAppIsKilledPlatform.
  NotificationWhenAppIsKilledPlatform() : super(token: _token);

  static final Object _token = Object();

  static NotificationWhenAppIsKilledPlatform _instance = MethodChannelNotificationWhenAppIsKilled();

  /// The default instance of [NotificationWhenAppIsKilledPlatform] to use.
  ///
  /// Defaults to [MethodChannelNotificationWhenAppIsKilled].
  static NotificationWhenAppIsKilledPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NotificationWhenAppIsKilledPlatform] when
  /// they register themselves.
  static set instance(NotificationWhenAppIsKilledPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> setNotificationOnKillService(ArgsForKillNotification argsForKillNotification) {
    throw UnimplementedError('setNotificationOnKillService() has not been implemented.');
  }

  Future<bool?> cancelNotificationOnKillService() {
    throw UnimplementedError('cancelNotificationOnKillService() has not been implemented.');
  }
}
