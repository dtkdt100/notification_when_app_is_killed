import 'dart:io';

import 'args_for_ios.dart';

class ArgsForKillNotification {
  /// Title of the notification
  final String title;

  /// Description of the notification
  final String description;

  /// Icon for Android notification from raw resources
  /// Example: '@raw/ic_launcher'
  final String? androidIcon;

  /// iOS specific arguments
  final ArgsForIos? argsForIos;

  ArgsForKillNotification(
      {required this.title,
      required this.description,
      this.androidIcon,
      this.argsForIos});

  Map<String, dynamic> toJson() {
    if (argsForIos != null && Platform.isIOS) {
      return {
        'title': title,
        'description': description,
        'icon': androidIcon,
        'argsForIos': argsForIos!.toJson(),
        'useDefaultSound': argsForIos!.useDefaultSound,
        'interruptionLevel': argsForIos!.interruptionLevel.index,
      };
    }
    return {
      'title': title,
      'description': description,
      'icon': androidIcon,
    };
  }
}
