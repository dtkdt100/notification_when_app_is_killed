import 'dart:io';

import 'args_for_ios.dart';

class ArgsForKillNotification {
  final String title;
  final String description;
  final ArgsForIos? argsForIos;

  ArgsForKillNotification({
    required this.title,
    required this.description,
    this.argsForIos,
  });

  Map<String, dynamic> toJson() {
    if (argsForIos != null && Platform.isIOS) {
      return {
        'title': title,
        'description': description,
        'argsForIos': argsForIos!.toJson(),
        'useDefaultSound': argsForIos!.useDefaultSound,
        'interruptionLevel': argsForIos!.interruptionLevel.index,
      };
    }
    return {
      'title': title,
      'description': description,
    };
  }
}
