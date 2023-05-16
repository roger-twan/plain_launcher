import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'provider/settings.dart';
import 'provider/card_list.dart';
import 'widget/edit_tips.dart';
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
  @override
  Widget build(BuildContext context) {
    final bool isCardEditing = Provider.of<Settings>(context).isCardEditing;
    List<dynamic> cardList = Provider.of<CardList>(context).cardList;
    final List<Widget> cardWidgetList =
        cardList.map((card) => CardWrapper(card: card)).toList();

    void onReorder(int oldIndex, int newIndex) {
      final List<dynamic> list = List.from(cardList);
      dynamic row = list.removeAt(oldIndex);
      list.insert(newIndex, row);

      Provider.of<CardList>(context, listen: false).setCardList(list);
    }

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
                onReorder: onReorder,
                buildDraggableFeedback: (context, constraints, child) => child,
                children: cardWidgetList),
          ],
        ),
      ),
      floatingActionButton: isCardEditing ? const EditActions() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
