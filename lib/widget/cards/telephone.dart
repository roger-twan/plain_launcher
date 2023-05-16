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
    return Column(
      children: const [Text('telephone')],
    );
  }
}
