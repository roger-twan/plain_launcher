import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/card.dart';
import '../provider/settings.dart';
import 'cards/bottom_sheet.dart';

class EditActions extends StatefulWidget {
  const EditActions({super.key});

  @override
  State<EditActions> createState() => _EditActionsState();
}

class _EditActionsState extends State<EditActions> {
  final popupMenu = GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    final double basicFontSize =
        Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return Wrap(
      children: [
        PopupMenuButton(
          key: popupMenu,
          onSelected: (CardType value) {
            showSheet(context, value);
          },
          child: ElevatedButton(
            onPressed: () => popupMenu.currentState?.showButtonMenu(),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(6, 4, 10, 4),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
            child: Wrap(
              children: [
                Icon(
                  Icons.add,
                  size: basicFontSize * 1.5,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text('新增', style: TextStyle(fontSize: basicFontSize)),
              ],
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
                value: CardType.telephone,
                child: Row(
                  children: [
                    Icon(Icons.phone_in_talk,
                        color: Colors.blue, size: basicFontSize),
                    const SizedBox(width: 10),
                    Text('语音电话',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize)),
                  ],
                )),
            PopupMenuItem(
                value: CardType.video,
                child: Row(
                  children: [
                    Icon(Icons.video_camera_front,
                        color: Colors.green, size: basicFontSize),
                    const SizedBox(width: 10),
                    Text('视频电话',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize)),
                  ],
                )),
            PopupMenuItem(
                value: CardType.app,
                child: Row(
                  children: [
                    Icon(Icons.apps, color: Colors.purple, size: basicFontSize),
                    const SizedBox(width: 10),
                    Text('应用程序',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize)),
                  ],
                )),
          ],
        ),
        ElevatedButton(
          onPressed: () => Provider.of<Settings>(context, listen: false)
              .setIsCardEditing(false),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          child: Wrap(
            children: [
              Icon(
                Icons.check,
                size: basicFontSize * 1.5,
              ),
              const SizedBox(
                width: 4,
              ),
              Text('完成', style: TextStyle(fontSize: basicFontSize)),
            ],
          ),
        ),
      ],
    );
  }
}
