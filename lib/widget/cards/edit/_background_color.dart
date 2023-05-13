import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

import '../../../const/colors.dart';

class BackgroundColor extends StatefulWidget {
  final bool? showIcon;
  final Color color;
  final Function? onChanged;

  const BackgroundColor(
      {super.key, this.showIcon, required this.color, this.onChanged});

  @override
  State<BackgroundColor> createState() => _BackgroundColorState();
}

class _BackgroundColorState extends State<BackgroundColor> {
  final ExpandedTileController _controller =
      ExpandedTileController(isExpanded: false);

  @override
  Widget build(BuildContext context) {
    final double basicFontSize =
        Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return ExpandedTile(
      controller: _controller,
      theme: const ExpandedTileThemeData(
          headerPadding: EdgeInsets.zero,
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
          Row(
            children: [
              if (widget.showIcon != null)
                Row(
                  children: [
                    Icon(Icons.palette,
                        color: Colors.orange, size: basicFontSize * 1.2),
                    const SizedBox(width: 4),
                  ],
                ),
              Text(
                '卡片颜色:',
                style: TextStyle(
                  color: widget.showIcon != null
                      ? Colors.grey[700]
                      : Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ],
          ),
          Container(
            width: basicFontSize * 1.2,
            height: basicFontSize * 1.2,
            decoration: BoxDecoration(
              color: widget.color,
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
          )
        ],
      ),
      trailing: const Icon(Icons.navigate_next),
      content: GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        children: cardColorList.map((color) {
          return GestureDetector(
            onTap: () {
              if (widget.onChanged != null) {
                widget.onChanged!(color);
              }
            },
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
