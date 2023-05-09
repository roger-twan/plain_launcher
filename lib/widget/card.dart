import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final Widget child;
  const CardWidget({super.key, required this.child});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red, child: widget.child);
  }
}
