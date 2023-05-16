import 'package:flutter/material.dart';

import '../../model/card.dart';

class VideoCardWidget extends StatefulWidget {
  final VideoCard card;

  const VideoCardWidget({super.key, required this.card});

  @override
  State<VideoCardWidget> createState() => _VideoCardWidgetState();
}

class _VideoCardWidgetState extends State<VideoCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('video')],
    );
  }
}
