import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/colors.dart';
import '../const/normal_system_app.dart';
import '../model/card.dart';

class CardList extends ChangeNotifier {
  static final CardList _instance = CardList._internal();
  factory CardList() => _instance;
  CardList._internal();

  late SharedPreferences? _preferences;
  List<dynamic> _cardList = [];

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    final List<String>? cardStringList =
        _preferences?.getStringList('cardList');

    if (cardStringList == null) {
      _cardList = normalSystemAppList
          .map((String packageName) => AppCard(
              id: normalSystemAppList.indexOf(packageName),
              isInit: false,
              packageName: packageName,
              backgroundColor:
                  cardColorList[Random().nextInt(cardColorList.length)]))
          .toList();
      setCardList(_cardList, false);
    } else {
      _cardList = cardStringList.map((String? e) {
        if (e != null) {
          Map<String, dynamic> json = jsonDecode(e);

          switch (json['type']) {
            case 'CardType.telephone':
              return TelephoneCard.fromJson(json);
            case 'CardType.video':
              return VideoCard.fromJson(json);
            case 'CardType.app':
              return AppCard.fromJson(json);
            default:
              break;
          }
        }
      }).toList();
    }
  }

  List<dynamic> get cardList => _cardList;

  Future<void> setCardList(List<dynamic> cardList, [notify = true]) async {
    final List<String> cardStringList = cardList.map((dynamic card) {
      switch (card.type) {
        case CardType.telephone:
          card as TelephoneCard;
          break;
        case CardType.video:
          card as VideoCard;
          break;
        case CardType.app:
          card as AppCard;
          break;
        default:
          break;
      }
      final String result = card.toJsonString();
      return result;
    }).toList();

    _cardList = cardList;
    await _preferences?.setStringList('cardList', cardStringList);
    if (notify) notifyListeners();
  }

  Future<void> add(dynamic card) async {
    _cardList.add(card);
    await setCardList(_cardList);
  }

  Future<void> update(dynamic card) async {
    final int index = _cardList.indexWhere((element) => element.id == card.id);
    _cardList[index] = card;
    await setCardList(_cardList);
  }

  Future<void> delete(dynamic card) async {
    _cardList.removeWhere((element) => element.id == card.id);
    await setCardList(_cardList);
  }
}
