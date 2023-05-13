import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import '../../../const/normal_system_app.dart';

class AppList extends StatefulWidget {
  final Function? onSelected;
  const AppList({super.key, this.onSelected});

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  final Future<List<Application>> _getList =
      DeviceApps.getInstalledApplications(
          includeSystemApps: true, includeAppIcons: true);
  int _filterCategory = 1; // 1: 常规应用, 2: 所有应用

  void selectedApp(String packageName) {
    if (widget.onSelected != null) {
      widget.onSelected!(packageName);
    }
  }

  void setFilterCategory(int value) {
    setState(() {
      _filterCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double basicFontSize =
        Theme.of(context).textTheme.bodyMedium!.fontSize!;

    return Column(children: [
      Row(
        children: [
          Expanded(
            child: InkWell(
                onTap: () => setFilterCategory(1),
                child: Ink(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: _filterCategory == 1
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      border: const Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                          right: BorderSide(color: Colors.grey, width: 0.5))),
                  child: Center(
                      child: Text(
                    '常规应用',
                    style: TextStyle(
                      color: _filterCategory == 1 ? Colors.white : Colors.black,
                    ),
                  )),
                )),
          ),
          Expanded(
            child: InkWell(
                onTap: () => setFilterCategory(2),
                child: Ink(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: _filterCategory == 2
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      border: const Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                          right: BorderSide(color: Colors.grey, width: 0.5))),
                  child: Center(
                      child: Text(
                    '所有应用',
                    style: TextStyle(
                      color: _filterCategory == 2 ? Colors.white : Colors.black,
                    ),
                  )),
                )),
          ),
        ],
      ),
      Expanded(
        child: FutureBuilder<List<Application>>(
          future: _getList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Application> list = snapshot.data!;
              List<Application> normalAppList = list.where((app) {
                return normalSystemAppList.contains(app.packageName) ||
                    !app.systemApp;
              }).toList();
              List<Application> showList =
                  _filterCategory == 1 ? normalAppList : list;

              return Container(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: showList.length,
                  itemBuilder: (context, index) {
                    Application app = showList[index];
                    ApplicationWithIcon appWithIcon =
                        app as ApplicationWithIcon;

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            selectedApp(appWithIcon.packageName);
                            Navigator.pop(context);
                          },
                          child: Ink(
                            child: Row(
                              children: [
                                SizedBox(
                                    width: basicFontSize * 1.5,
                                    height: basicFontSize * 1.5,
                                    child: Image.memory(appWithIcon.icon)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    appWithIcon.appName,
                                    style: const TextStyle(
                                        overflow: TextOverflow.visible),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ]);
  }
}
