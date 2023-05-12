import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/settings.dart';
import 'card_management.dart';
import 'background_color.dart';
import 'each_row_count.dart';
import 'font_size.dart';
import 'time_format.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final List<Widget> settingList = [
    const CardManagement(),
    const FontSizeSetting(),
    const TimeFormatSetting(),
    const EachRowCountSetting(),
    const BackgroundColorSetting(),
  ];

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: Provider.of<Settings>(context).fontSize * 1.5,
        onPressed: () {
          Provider.of<Settings>(context, listen: false).setIsCardEditing(false);
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                        children: settingList.map((settingWidget) {
                      return Column(children: [
                        settingWidget,
                        if (settingList.indexOf(settingWidget) !=
                            settingList.length - 1)
                          const Divider()
                      ]);
                    }).toList()),
                  ),
                );
              });
        },
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
        ));
  }
}
