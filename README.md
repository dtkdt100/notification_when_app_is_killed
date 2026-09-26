# Notification When App Is Killed

[![pub package](https://img.shields.io/pub/v/notification_when_app_is_killed.svg)](https://pub.dev/packages/notification_when_app_is_killed)
[![pub points](https://img.shields.io/pub/points/notification_when_app_is_killed)](https://pub.dev/packages/notification_when_app_is_killed/score)
[![license](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](https://github.com/dtkdt100/notification_when_app_is_killed/blob/main/LICENSE)

Show a local notification with a title and description when the user kills your app
(swipes it away from the recent apps list), on both **Android** and **iOS**.

<table>
  <tr>
    <th>iOS</th>
    <th>Android</th>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/dtkdt100/notification_when_app_is_killed/main/screenshots/ios_phone_is_killed_example.gif" alt="iOS demo" width="250"></td>
    <td><img src="https://raw.githubusercontent.com/dtkdt100/notification_when_app_is_killed/main/screenshots/android_phone_is_killed_example.gif" alt="Android demo" width="250"></td>
  </tr>
</table>

## Features

- Notification with a custom title and description when the app is killed
- Custom notification icon on Android
- iOS interruption levels (`passive`, `active`, `timeSensitive`, `critical`) and default sound
- Enable or cancel the notification at any time
- Requests the notification permission for you

## Installation

```sh
flutter pub add notification_when_app_is_killed
```

### Android

No extra setup is needed. The plugin declares the `POST_NOTIFICATIONS` permission itself.

### iOS

**1. Enable the notification permission** in `ios/Podfile`
(required by [permission_handler](https://pub.dev/packages/permission_handler)):

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        # dart: PermissionGroup.notification
        'PERMISSION_NOTIFICATIONS=1',
      ]
    end
  end
end
```

**2. Forward the terminate event** in `ios/Runner/AppDelegate.swift`:

```swift
import UIKit
import Flutter
import UserNotifications
import notification_when_app_is_killed

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Add this method
  override func applicationWillTerminate(_ application: UIApplication) {
    NotificationWhenAppIsKilledPlugin.instance.applicationWillTerminate()
  }
}
```

See the full [example AppDelegate.swift](https://github.com/dtkdt100/notification_when_app_is_killed/blob/main/example/ios/Runner/AppDelegate.swift).

## Usage

```dart
import 'package:notification_when_app_is_killed/model/args_for_ios.dart';
import 'package:notification_when_app_is_killed/model/args_for_kill_notification.dart';
import 'package:notification_when_app_is_killed/notification_when_app_is_killed.dart';

final notificationWhenAppIsKilled = NotificationWhenAppIsKilled();
```

### Enable the notification

```dart
final bool? isSet = await notificationWhenAppIsKilled.setNotificationOnKillService(
  ArgsForKillNotification(
    title: 'The app is killed',
    description: 'You can see this notification when the app is killed',
    argsForIos: ArgsForIos(
      interruptionLevel: InterruptionLevel.critical,
      useDefaultSound: true,
    ),
  ),
);
```

Returns `true` when the notification is set, `false` if the notification
permission was denied, and `null` on error.

### Cancel the notification

```dart
await notificationWhenAppIsKilled.cancelNotificationOnKillService();
```

### Options

| Parameter | Platform | Description |
| --- | --- | --- |
| `title` | Both | Notification title (required) |
| `description` | Both | Notification body (required) |
| `androidIcon` | Android | Name of a mipmap resource to use as the icon (default: the app icon) |
| `argsForIos.interruptionLevel` | iOS 15+ | `passive` (default), `active`, `timeSensitive` or `critical` |
| `argsForIos.useDefaultSound` | iOS | Play the default notification sound (default: `true`) |

> `timeSensitive` requires the *Time Sensitive Notifications* capability in Xcode,
> and `critical` requires an [entitlement from Apple](https://developer.apple.com/contact/request/notifications-critical-alerts-entitlement/).

## Notes

- The kill notification works only in **release** mode, not in debug mode.

## Credit

Thanks to [gdelataillade](https://github.com/gdelataillade), who wrote most of this code.
Check out his Medium article:
[Displaying a notification when your Flutter app is killed](https://medium.com/@gdelataillade/displaying-a-notification-when-your-flutter-app-is-killed-4ef25cc3f193).
