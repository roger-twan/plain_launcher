import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import '../../model/card.dart';

class AppCardWidget extends StatefulWidget {
  final AppCard card;

  const AppCardWidget({super.key, required this.card});

  @override
  State<AppCardWidget> createState() => _AppCardWidgetState();
}

class _AppCardWidgetState extends State<AppCardWidget> {
  Future<ApplicationWithIcon> _getAppInfo() async {
    Application? app = await DeviceApps.getApp(widget.card.packageName, true);
    ApplicationWithIcon appWithIcon = app as ApplicationWithIcon;
    return appWithIcon;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getAppInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(child: Image.memory(snapshot.data!.icon)),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  snapshot.data!.appName,
                  style: const TextStyle(
                      color: Colors.white, overflow: TextOverflow.visible),
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
