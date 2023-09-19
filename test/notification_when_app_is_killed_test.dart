import 'package:flutter_test/flutter_test.dart';
import 'package:notification_when_app_is_killed/notification_when_app_is_killed_platform_interface.dart';
import 'package:notification_when_app_is_killed/notification_when_app_is_killed_method_channel.dart';

// class MockNotificationWhenAppIsKilledPlatform
//     with MockPlatformInterfaceMixin
//     implements NotificationWhenAppIsKilledPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

void main() {
  final NotificationWhenAppIsKilledPlatform initialPlatform = NotificationWhenAppIsKilledPlatform.instance;

  test('$MethodChannelNotificationWhenAppIsKilled is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNotificationWhenAppIsKilled>());
  });

  // test('getPlatformVersion', () async {
  //   NotificationWhenAppIsKilled notificationWhenAppIsKilledPlugin = NotificationWhenAppIsKilled();
  //   MockNotificationWhenAppIsKilledPlatform fakePlatform = MockNotificationWhenAppIsKilledPlatform();
  //   NotificationWhenAppIsKilledPlatform.instance = fakePlatform;
  //
  //   //expect(await notificationWhenAppIsKilledPlugin.getPlatformVersion(), '42');
  // });
}
