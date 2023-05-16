import 'package:flutter/material.dart';
import 'package:plain_launcher/provider/settings.dart';
import 'package:provider/provider.dart';

class EachRowCountSetting extends StatefulWidget {
  const EachRowCountSetting({super.key});

  @override
  State<EachRowCountSetting> createState() => _EachRowCountSettingState();
}

class _EachRowCountSettingState extends State<EachRowCountSetting> {
  @override
  Widget build(BuildContext context) {
    final int eachRowCount = Provider.of<Settings>(context).eachRowCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('每行卡片数量:'),
        ToggleButtons(
          isSelected: [eachRowCount == 2, eachRowCount == 3],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onPressed: (int index) {
            final int value = index == 0 ? 2 : 3;
            Provider.of<Settings>(context, listen: false)
                .setEachRowCount(value);
          },
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              child: const Text('2'),
            ),
            Container(
              padding: EdgeInsets.zero,
              child: const Text('3'),
            ),
          ],
        ),
      ],
    );
  }
}
