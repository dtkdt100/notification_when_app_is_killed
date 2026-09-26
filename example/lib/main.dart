import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_when_app_is_killed/model/args_for_ios.dart';
import 'package:notification_when_app_is_killed/model/args_for_kill_notification.dart';
import 'package:notification_when_app_is_killed/notification_when_app_is_killed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification When App Is Killed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _notificationWhenAppIsKilledPlugin = NotificationWhenAppIsKilled();
  final _titleController = TextEditingController(text: 'The app is killed');
  final _descriptionController = TextEditingController(
    text: 'You can see this notification when the app is killed',
  );

  bool _isEnabled = false;
  bool _isBusy = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _enable() async {
    bool? result;
    try {
      result = await _notificationWhenAppIsKilledPlugin
          .setNotificationOnKillService(
            ArgsForKillNotification(
              title: _titleController.text,
              description: _descriptionController.text,
              androidIcon: 'ic_launcher',
              argsForIos: ArgsForIos(
                interruptionLevel: InterruptionLevel.critical,
                useDefaultSound: true,
              ),
            ),
          );
    } on PlatformException {
      result = null;
    }

    if (result == true) {
      setState(() => _isEnabled = true);
      _showMessage('Enabled. Now close the app to see the notification.');
    } else if (result == false) {
      _showMessage('Notification permission denied. Allow it in Settings.');
    } else {
      _showMessage('Something went wrong while enabling the notification.');
    }
  }

  Future<void> _disable() async {
    bool? result;
    try {
      result = await _notificationWhenAppIsKilledPlugin
          .cancelNotificationOnKillService();
    } on PlatformException {
      result = null;
    }

    if (result == true) {
      setState(() => _isEnabled = false);
      _showMessage('Disabled. No notification will be shown.');
    } else {
      _showMessage('Something went wrong while disabling the notification.');
    }
  }

  Future<void> _toggle(bool enable) async {
    if (_isBusy) return;
    FocusScope.of(context).unfocus();
    setState(() => _isBusy = true);
    await (enable ? _enable() : _disable());
    if (mounted) setState(() => _isBusy = false);
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification When App Is Killed')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _StatusCard(
              isEnabled: _isEnabled,
              isBusy: _isBusy,
              onChanged: _toggle,
            ),
            const SizedBox(height: 16),
            _NotificationCard(
              titleController: _titleController,
              descriptionController: _descriptionController,
              enabled: !_isEnabled && !_isBusy,
            ),
            const SizedBox(height: 16),
            const _HowToCard(),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.isEnabled,
    required this.isBusy,
    required this.onChanged,
  });

  final bool isEnabled;
  final bool isBusy;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      color: isEnabled ? colors.primaryContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isEnabled
                  ? Icons.notifications_active
                  : Icons.notifications_off_outlined,
              size: 40,
              color: isEnabled ? colors.primary : colors.outline,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEnabled ? 'Enabled' : 'Disabled',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    isEnabled
                        ? 'A notification will appear when the app is killed.'
                        : 'Turn on to show a notification when the app is killed.',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            isBusy
                ? const SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  )
                : Switch(value: isEnabled, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.titleController,
    required this.descriptionController,
    required this.enabled,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleController,
              enabled: enabled,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              enabled: enabled,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            if (!enabled) ...[
              const SizedBox(height: 8),
              Text(
                'Turn it off to edit the text.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HowToCard extends StatelessWidget {
  const _HowToCard();

  static const _steps = [
    'Turn the switch on and allow notifications.',
    'Open the recent apps screen.',
    'Swipe this app away to kill it.',
    'The notification appears.',
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How to try it', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            for (var i = 0; i < _steps.length; i++)
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: CircleAvatar(radius: 14, child: Text('${i + 1}')),
                title: Text(_steps[i]),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Works in release mode only (flutter run --release).',
                    style: textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
