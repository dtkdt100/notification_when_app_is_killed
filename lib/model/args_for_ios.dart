class ArgsForIos {
  ArgsForIos({
    this.interruptionLevel = InterruptionLevel.passive,
    this.useDefaultSound = true,
  });

  /// Specifies whether the default notification sound should be used.
  final bool useDefaultSound;

  /// The interruption level that indicates the priority and
  /// delivery timing of a notification.
  ///
  /// This property is only applicable to iOS 15.0 and macOS 12.0 or newer.
  /// https://developer.apple.com/documentation/usernotifications/unnotificationcontent/3747256-interruptionlevel
  final InterruptionLevel interruptionLevel;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'useDefaultSound': useDefaultSound,
      'interruptionLevel': interruptionLevel.index,
    };
  }
}

enum InterruptionLevel {
  /// The system adds the notification to the notification
  /// list without lighting up the screen or playing a sound.
  ///
  /// Corresponds to [`UNNotificationInterruptionLevel.passive`](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel/passive).
  passive,

  /// The system presents the notification immediately,
  /// lights up the screen, and can play a sound.
  ///
  /// Corresponds to [`UNNotificationInterruptionLevel.active`](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel/active).
  active,

  /// The system presents the notification immediately,
  /// lights up the screen, and can play a sound,
  /// but won’t break through system notification controls.
  ///
  /// In order for this to work, the 'Time Sensitive Notifications'
  /// capability needs to be added to the iOS project.
  /// See https://help.apple.com/xcode/mac/current/#/dev88ff319e7
  ///
  /// Corresponds to [`UNNotificationInterruptionLevel.timeSensitive`](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel/timesensitive).
  timeSensitive,

  /// The system presents the notification immediately,
  /// lights up the screen, and bypasses the mute switch to play a sound.
  ///
  /// Subject to specific approval from Apple:
  /// https://developer.apple.com/contact/request/notifications-critical-alerts-entitlement/
  ///
  /// Corresponds to [`UNNotificationInterruptionLevel.critical`](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel/critical).
  critical
}
