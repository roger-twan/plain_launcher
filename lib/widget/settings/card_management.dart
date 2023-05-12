import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/settings.dart';

class CardManagement extends StatefulWidget {
  const CardManagement({super.key});

  @override
  State<CardManagement> createState() => _CardManagementState();
}

class _CardManagementState extends State<CardManagement> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Provider.of<Settings>(context, listen: false).setIsCardEditing(true);
        Navigator.of(context).pop();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [Text('卡片管理'), Icon(Icons.navigate_next)],
      ),
    );
  }
}
