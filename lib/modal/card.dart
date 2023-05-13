import 'package:flutter/material.dart';

enum CardType { telephone, video, app }

class TelephoneCard {
  CardType type = CardType.telephone;
  int id;
  String name;
  int? number;
  String? avatar;
  Color? avatarBackgroundColor;
  Color backgroundColor;

  TelephoneCard(
      {required this.id,
      required this.name,
      required this.number,
      this.avatar,
      this.avatarBackgroundColor,
      required this.backgroundColor});

  TelephoneCard copyWith({
    int? id,
    String? name,
    int? number,
    String? avatar,
    Color? avatarBackgroundColor,
    Color? backgroundColor,
  }) {
    return TelephoneCard(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      avatar: avatar ?? this.avatar,
      avatarBackgroundColor:
          avatarBackgroundColor ?? this.avatarBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  void trigger() {
    // TODO: call number
  }
}

class VideoCard {
  CardType type = CardType.video;
  String name;
  String url;
  String avatar;

  VideoCard({required this.name, required this.url, required this.avatar});

  void call() {
    // TODO: call video
  }
}

class AppCard {
  CardType type = CardType.app;
  int id;
  bool isInit = false;
  String packageName;
  Color backgroundColor;

  AppCard({
    required this.id,
    required this.isInit,
    required this.packageName,
    required this.backgroundColor,
  });

  AppCard copyWith(
      {int? id, bool? isInit, String? packageName, Color? backgroundColor}) {
    return AppCard(
      id: id ?? this.id,
      isInit: isInit ?? this.isInit,
      packageName: packageName ?? this.packageName,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  void open() {
    // TODO: open app
  }
}
