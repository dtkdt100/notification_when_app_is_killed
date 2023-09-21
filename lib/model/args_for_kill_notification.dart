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

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        if (argsForIos != null && Platform.isIOS) 'argsForIos': argsForIos!.toJson(),
      };
}
