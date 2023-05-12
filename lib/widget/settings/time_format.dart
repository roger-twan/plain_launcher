import 'package:flutter/material.dart';
import 'package:plain_launcher/provider/settings.dart';
import 'package:provider/provider.dart';

class TimeFormatSetting extends StatefulWidget {
  const TimeFormatSetting({super.key});

  @override
  State<TimeFormatSetting> createState() => _TimeFormatSettingState();
}

class _TimeFormatSettingState extends State<TimeFormatSetting> {
  @override
  Widget build(BuildContext context) {
    final TimeFormatType timeFormatType =
        Provider.of<Settings>(context).timeFormatType;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('时间格式:'),
        ToggleButtons(
          isSelected: [
            timeFormatType == TimeFormatType.twelve,
            timeFormatType == TimeFormatType.twentyFour
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onPressed: (int index) {
            late TimeFormatType value;

            if (index == 0) {
              value = TimeFormatType.twelve;
            } else if (index == 1) {
              value = TimeFormatType.twentyFour;
            }

            Provider.of<Settings>(context, listen: false)
                .setTimeFormatType(value);
          },
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              child: const Text('12'),
            ),
            Container(
              padding: EdgeInsets.zero,
              child: const Text('24'),
            ),
          ],
        ),
      ],
    );
  }
}
