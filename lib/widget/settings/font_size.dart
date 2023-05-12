import 'package:flutter/material.dart';
import 'package:plain_launcher/provider/settings.dart';
import 'package:provider/provider.dart';

class FontSizeSetting extends StatefulWidget {
  const FontSizeSetting({super.key});

  @override
  State<FontSizeSetting> createState() => _FontSizeSettingState();
}

class _FontSizeSettingState extends State<FontSizeSetting> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('字体大小:'),
        Slider(
          value: Provider.of<Settings>(context).fontSize,
          min: 16,
          max: 40,
          onChanged: (double value) {
            Provider.of<Settings>(context, listen: false).setFontSize(value);
          },
        ),
      ],
    );
  }
}
