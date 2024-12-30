import 'dart:io';

import 'args_for_ios.dart';

class ArgsForKillNotification {
  final String title;
  final String description;
  final String? androidIcon;
  final ArgsForIos? argsForIos;

  ArgsForKillNotification({
    required this.title,
    required this.description,
    this.argsForIos,
    this.androidIcon
  });

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
