class ArgsForKillNotification {
  final String title;
  final String description;

  ArgsForKillNotification({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
