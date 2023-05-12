import 'package:flutter/material.dart';
import 'package:plain_launcher/widget/edit_tips.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'provider/settings.dart';
import 'widget/cards/wrapper.dart';
import 'widget/time.dart';
import 'widget/settings/index.dart';
import 'widget/edit_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _tiles = const [
    CardWrapper(child: Icon(Icons.filter_1, size: 30)),
    CardWrapper(child: Icon(Icons.filter_2, size: 30)),
    CardWrapper(child: Icon(Icons.filter_3, size: 30)),
    CardWrapper(child: Icon(Icons.filter_4, size: 30)),
    CardWrapper(child: Icon(Icons.filter_5, size: 30)),
    CardWrapper(child: Icon(Icons.filter_6, size: 30)),
    CardWrapper(child: Icon(Icons.filter_7, size: 30)),
    CardWrapper(child: Icon(Icons.filter_8, size: 30)),
    CardWrapper(child: Icon(Icons.filter_9, size: 30)),
  ];
  OverlayEntry? overlayEntry;
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _tiles.removeAt(oldIndex);
      _tiles.insert(newIndex, row);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isCardEditing = Provider.of<Settings>(context).isCardEditing;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isCardEditing ? EditTips().showTips(context) : EditTips().removeTips();
    });

    return Scaffold(
      backgroundColor: Provider.of<Settings>(context).backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () => {},
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Time(),
                            SettingsWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            ReorderableWrap(
                needsLongPressDraggable: false,
                enableReorder: isCardEditing,
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8,
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                onReorder: _onReorder,
                buildDraggableFeedback: (context, constraints, child) => child,
                children: _tiles),
          ],
        ),
      ),
      floatingActionButton: isCardEditing ? const EditActions() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
