import 'package:flutter/material.dart';

enum CardType { telephone, video, app }

class TelephoneCard {
  CardType type = CardType.telephone;
  int id;
  String name;
  int? number;
  String? avatar;
  Color? backgroundColor;

  TelephoneCard(
      {required this.id,
      required this.name,
      required this.number,
      this.avatar,
      this.backgroundColor});

  TelephoneCard copyWith({
    int? id,
    String? name,
    int? number,
    String? avatar,
    Color? backgroundColor,
  }) {
    return TelephoneCard(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      avatar: avatar ?? this.avatar,
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
  String name;
  String url;
  String icon;

  AppCard({required this.name, required this.url, required this.icon});

  void open() {
    // TODO: open app
  }
}
