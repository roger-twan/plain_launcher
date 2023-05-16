import 'dart:io';

import 'package:flutter/material.dart';
import '../../model/card.dart';

class TelephoneCardWidget extends StatefulWidget {
  final TelephoneCard card;

  const TelephoneCardWidget({super.key, required this.card});

  @override
  State<TelephoneCardWidget> createState() => _TelephoneCardWidgetState();
}

class _TelephoneCardWidgetState extends State<TelephoneCardWidget> {
  @override
  Widget build(BuildContext context) {
    final double basicFontSize =
        Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return Column(
      children: [
        Expanded(
          child: widget.card.avatar == null
            ? Center(
                child: Text(
                    widget.card.name == ''
                        ? ''
                        : widget.card.name.substring(
                            widget.card.name.length - 2,
                            widget.card.name.length),
                    style: TextStyle(fontSize: basicFontSize)),
              )
            : SizedBox(
              width: double.infinity,
              child: CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(File(widget.card.avatar!))),
            ) 
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          widget.card.name,
          style: const TextStyle(
              color: Colors.white, overflow: TextOverflow.visible),
        )
      ],
    );
  }
}
