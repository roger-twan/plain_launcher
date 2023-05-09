import 'package:flutter/material.dart';
import 'package:plain_launcher/provider/settings.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {
              Provider.of<Settings>(context, listen: false)
                  .setTimeFormatType(TimeFormatType.twelve)
            },
        child: const Text('设置'));
  }
}
