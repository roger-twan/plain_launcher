import 'package:flutter/material.dart';

import '../../model/card.dart';
import 'edit/app.dart';
import 'edit/telephone.dart';

void showSheet(BuildContext context, CardType type, [dynamic card]) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        late Widget widget;

        switch (type) {
          case CardType.telephone:
            widget = EditTelephone(telephoneCard: card);
            break;
          // case CardType.video:
          //   widget = const EditVideo();
          //   break;
          case CardType.app:
            widget = EditApp(appCard: card);
            break;
          default:
            break;
        }

        return widget;
      });
}
