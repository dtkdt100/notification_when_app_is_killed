# Notification When App Is Killed

Push notification with title and description when the app is killed.

Credit to  [gdelataillade](https://github.com/gdelataillade)


![Alt Text](./example/screenshots/ios_phone_is_killed_example.gif "iOS") ![Alt Text](./example/screenshots/android_phone_is_killed_example.gif "Android")


## Getting Started

### iOS

1. You will need notification permission so add this to your ios/Podfile

```dart
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

2. Add this to your `ios/AppDelegate.swift'

```swift
.
.
import UserNotifications
import notification_when_app_is_killed

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
   override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

   .
   .
   .
  }

  override func applicationWillTerminate(_ application: UIApplication) {
    let notificationWhenAppIsKilledInstance = NotificationWhenAppIsKilledPlugin.instance
    notificationWhenAppIsKilledInstance.applicationWillTerminate();
  }
}
```
see [example AppDelegate.swift](https://github.com/dtkdt100/notification_when_app_is_killed/blob/main/example/ios/Runner/AppDelegate.swift)

## How to use

### setNotificationOnKillService:
```dart
final _notificationWhenAppIsKilledPlugin = NotificationWhenAppIsKilled();

ArgsForIos argsForIos = ArgsForIos(
  interruptionLevel: InterruptionLevel.critical,
  useDefaultSound: true,
);
await _notificationWhenAppIsKilledPlugin.setNotificationOnKillService(
  ArgsForKillNotification(
      title: 'The app is killed',
      description:
          'You can see this notification when the app is killed',
      argsForIos: argsForIos),
)
```

### cancelNotificationOnKill:
```dart
final _notificationWhenAppIsKilledPlugin = NotificationWhenAppIsKilled();

await _notificationWhenAppIsKilledPlugin
              .cancelNotificationOnKillService()
)
```

## Credit

Thanks to [gdelataillade](https://github.com/gdelataillade), most of this code is his. Checkout his article in Medium: https://medium.com/@gdelataillade/displaying-a-notification-when-your-flutter-app-is-killed-4ef25cc3f193

## Notes

Checking this package and the onKill notification will only work under release and not under dabug
