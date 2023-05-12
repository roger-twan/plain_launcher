import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/settings.dart';

class EditTips {
  static final EditTips _instance = EditTips._internal();
  factory EditTips() => _instance;
  EditTips._internal();

  OverlayEntry? overlayEntry;

  void showTips(BuildContext context) async {
    if (overlayEntry != null) return null;

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 0,
        top: 0,
        child: Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(
                10, MediaQuery.of(context).viewPadding.top + 10, 10, 10),
            decoration: const BoxDecoration(
                color: Colors.green,
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)]),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.white,
                  size: Provider.of<Settings>(context).fontSize * 1.5,
                ),
                const SizedBox(width: 10),
                const Expanded(
                    child: Text(
                  '点击卡片可修改、删除，拖拽卡片可排序',
                  style: TextStyle(color: Colors.white),
                ))
              ],
            ),
          ),
        ),
      );
    });
    Overlay.of(context).insert(overlayEntry!);
  }

  void removeTips() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
