import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bottom_sheet.dart';
import '../../model/card.dart';
import '../../provider/settings.dart';
import 'app.dart';
import 'telephone.dart';
import 'video.dart';

class CardWrapper extends StatefulWidget {
  final dynamic card;
  const CardWrapper({super.key, required this.card});

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

    late Widget cardWidget;
    switch (widget.card.type) {
      case CardType.telephone:
        widget.card as TelephoneCard;
        cardWidget = TelephoneCardWidget(card: widget.card);
        break;
      case CardType.video:
        widget.card as VideoCard;
        cardWidget = VideoCardWidget(card: widget.card);
        break;
      case CardType.app:
        widget.card as AppCard;
        cardWidget = AppCardWidget(card: widget.card);
        break;
      default:
        break;
    }

    return Material(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              if (isCardEditing) {
                showSheet(context, widget.card.type, widget.card);
              } else {
                widget.card.handle();
              }
            },
            child: Ink(
              width: cardWidth,
              height: cardWidth,
              decoration: BoxDecoration(
                color: widget.card.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  padding: const EdgeInsets.all(10), child: cardWidget),
            ),
          ),
        ],
      ),
    );
  }
}
