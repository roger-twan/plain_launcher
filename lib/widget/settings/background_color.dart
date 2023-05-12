import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:plain_launcher/const/colors.dart';
import 'package:plain_launcher/provider/settings.dart';
import 'package:provider/provider.dart';

class BackgroundColorSetting extends StatefulWidget {
  const BackgroundColorSetting({super.key});

  @override
  State<BackgroundColorSetting> createState() => _BackgroundColorSettingState();
}

class _BackgroundColorSettingState extends State<BackgroundColorSetting> {
  final ExpandedTileController _controller =
      ExpandedTileController(isExpanded: false);
  @override
  Widget build(BuildContext context) {
    final double basicFontSize =
        Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return ExpandedTile(
      controller: _controller,
      theme: const ExpandedTileThemeData(
          headerPadding: EdgeInsets.only(top: 4),
          headerRadius: 0,
          headerSplashColor: Colors.transparent,
          titlePadding: EdgeInsets.zero,
          trailingPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          contentRadius: 0,
          contentBackgroundColor: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('背景颜色:'),
          Container(
            width: basicFontSize * 1.2,
            height: basicFontSize * 1.2,
            decoration: BoxDecoration(
              color: Provider.of<Settings>(context).backgroundColor,
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
          )
        ],
      ),
      trailing: const Icon(Icons.navigate_next),
      content: GridView.count(
        crossAxisCount: 6,
        shrinkWrap: true,
        children: backgroundColorList.map((color) {
          return GestureDetector(
            onTap: () => Provider.of<Settings>(context, listen: false)
                .setBackgroundColor(color),
            child: Container(
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
