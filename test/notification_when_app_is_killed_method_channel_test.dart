import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notification_when_app_is_killed/notification_when_app_is_killed_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelNotificationWhenAppIsKilled platform = MethodChannelNotificationWhenAppIsKilled();
  const MethodChannel channel = MethodChannel('notification_when_app_is_killed');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await platform.getPlatformVersion(), '42');
  // });
}
