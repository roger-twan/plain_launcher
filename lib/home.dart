import 'package:flutter/material.dart';
import 'widget/card.dart';
import 'widget/time.dart';
import 'widget/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        CardWidget(
          child: Row(
            children: const [
              Time(),
              SettingsWidget(),
            ],
          ),
        ),
        TextButton(onPressed: () => {}, child: const Text('data')),
      ],
    ));
  }
}
