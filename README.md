# Notification When App Is Killed

Push notification with title and description when the app is killed.

Credit to  [gdelataillade](https://github.com/gdelataillade)

iOS | Anroid
:-: | :-:
<video src='https://github.com/dtkdt100/notification_when_app_is_killed/assets/63166757/9ac266eb-fa1a-4e86-8465-c00d908fce6c' width=180/> | <video src='https://github.com/dtkdt100/notification_when_app_is_killed/assets/63166757/eeaeda78-3a58-4e40-8d4c-bd63558e8c34' width=180/>

## Getting Started

### iOS

You will need notification permission so add this to your ios/Podfile

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

## How to use

### setNotificationOnKillService:
```dart
final _notificationWhenAppIsKilledPlugin = NotificationWhenAppIsKilled();

await _notificationWhenAppIsKilledPlugin.setNotificationOnKillService(
  ArgsForKillNotification(
      title: 'The app is killed',
      description:
          'You can see this notification when the app is killed'),
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

Tahnks to [gdelataillade](https://github.com/gdelataillade), most of this code is his. Checkout his article in Medium: https://medium.com/@gdelataillade/displaying-a-notification-when-your-flutter-app-is-killed-4ef25cc3f193

## Notes

Checking this package and the onKill notification will only work under release and not under dabug
