import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const/colors.dart';
import '../../provider/settings.dart';

class CardWrapper extends StatefulWidget {
  final Widget child;
  const CardWrapper({super.key, required this.child});

  @override
  State<CardWrapper> createState() => _CardWrapperState();
}

class _CardWrapperState extends State<CardWrapper> {
  @override
  Widget build(BuildContext context) {
    final int eachRowCount = Provider.of<Settings>(context).eachRowCount;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double contentWidth = screenWidth - 16 - 8 * (eachRowCount - 1);
    final double cardWidth = contentWidth / eachRowCount;
    final bool isCardEditing = Provider.of<Settings>(context).isCardEditing;

    return Material(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          InkWell(
            onTap: () => {
              if (isCardEditing)
                {
                  // TODO: edit
                }
              else
                {
                  // TODO: call
                }
            },
            child: Ink(
              width: cardWidth,
              height: cardWidth,
              decoration: BoxDecoration(
                color: cardColorList[Random().nextInt(cardColorList.length)],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  padding: const EdgeInsets.all(10), child: widget.child),
            ),
          ),
        ],
      ),
    );
  }
}
