import 'dart:math';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:provider/provider.dart';
import '../../../provider/card_list.dart';
import '../../../widget/cards/edit/_app_list.dart';
import '../../../widget/cards/edit/_background_color.dart';
import '../../../const/colors.dart';
import '../../../model/card.dart';
import '_bottom_actions.dart';

class EditApp extends StatefulWidget {
  final AppCard? appCard;
  const EditApp({super.key, this.appCard});

  @override
  State<EditApp> createState() => _EditAppState();
}

class _EditAppState extends State<EditApp> {
  bool _isEditing = false;
  final ExpandedTileController _controller =
      ExpandedTileController(isExpanded: false);
  late CardList _cardList;
  AppCard? _appCard;
  bool _isAppSelected = true;

  @override
  void initState() {
    super.initState();

    _isEditing = widget.appCard != null;
    _cardList = Provider.of<CardList>(context, listen: false);

    _appCard = AppCard(
        id: _isEditing
            ? widget.appCard!.id
            : DateTime.now().millisecondsSinceEpoch,
        packageName: _isEditing ? widget.appCard!.packageName : '',
        isRestart: _isEditing ? widget.appCard!.isRestart : false,
        backgroundColor: _isEditing
            ? widget.appCard!.backgroundColor
            : cardColorList[Random().nextInt(cardColorList.length)]);
  }

  void setAppCard(AppCard value) {
    setState(() {
      _appCard = value;
    });
  }

  void setIsAppSelected(bool value) {
    setState(() {
      _isAppSelected = value;
    });
  }

  Future<ApplicationWithIcon> _getAppInfo() async {
    Application? app = await DeviceApps.getApp(_appCard!.packageName, true);
    ApplicationWithIcon appWithIcon = app as ApplicationWithIcon;
    return appWithIcon;
  }

  Future<void> save() async {
    if (_appCard!.packageName.isEmpty) {
      setIsAppSelected(false);
    } else {
      if (_isEditing) {
        await _cardList.update(_appCard);
      } else {
        await _cardList.add(_appCard);
      }
    }

    if (context.mounted) Navigator.pop(context);
  }

  Future<void> delete() async {
    await _cardList.delete(_appCard);
    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double basicFontSize =
        Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setIsAppSelected(true);
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) =>
                            AppList(onSelected: (String packageName) {
                              setAppCard(
                                  _appCard!.copyWith(packageName: packageName));
                            }));
                  },
                  child: Stack(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('应用:'),
                        Row(
                          children: [
                            if (_appCard!.packageName.isNotEmpty)
                              FutureBuilder(
                                  future: _getAppInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Row(
                                        children: [
                                          SizedBox(
                                              width: basicFontSize,
                                              height: basicFontSize,
                                              child: Image.memory(
                                                  snapshot.data!.icon)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(snapshot.data!.appName)
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                            const Icon(Icons.navigate_next)
                          ],
                        )
                      ],
                    ),
                    if (!_isAppSelected)
                      Positioned(
                        top: 8,
                        right: 30,
                        child: Text('应用必选',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: basicFontSize * 0.5)),
                      )
                  ]),
                ),
                const Divider(),
                ExpandedTile(
                  controller: _controller,
                  trailingRotation: 0,
                  theme: const ExpandedTileThemeData(
                    headerPadding: EdgeInsets.zero,
                    headerRadius: 0,
                    headerSplashColor: Colors.transparent,
                    titlePadding: EdgeInsets.zero,
                    trailingPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.all(10),
                    contentRadius: 0,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('重新启动:'),
                      Switch(
                        value: _appCard?.isRestart ?? false,
                        onChanged: (bool value) {
                          setAppCard(_appCard!.copyWith(isRestart: value));
                        },
                      )
                    ],
                  ),
                  trailing: Icon(
                    Icons.help_outline,
                    color: Colors.grey[700],
                    size: basicFontSize * 0.8,
                  ),
                  content: Text('打开开关后每次点击应用会重启应用，应对在应用内误点，不知道如何回到应用主页的情况。',
                      style: TextStyle(fontSize: basicFontSize * 0.8)),
                ),
                const Divider(),
                BackgroundColor(
                  color: _appCard!.backgroundColor,
                  onChanged: (Color value) =>
                      setAppCard(_appCard!.copyWith(backgroundColor: value)),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          BottomActions(
            secondaryTitle: _isEditing ? '删除' : '取消',
            onPrimaryTaped: () async => await save(),
            onSecondaryTaped: () async {
              if (_isEditing) {
                await delete();
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
