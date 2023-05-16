import 'dart:convert';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import '../utils/index.dart';

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

  factory TelephoneCard.fromJson(Map<String, dynamic> json) {
    return TelephoneCard(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      avatar: json['avatar'],
      avatarBackgroundColor: json['avatarBackgroundColor'],
      backgroundColor: json['backgroundColor'],
    );
  }

  String toJsonString() {
    final Map<String, dynamic> json = {
      'type': type.toString(),
      'id': id,
      'name': name,
      'number': number,
      'avatar': avatar,
      'avatarBackgroundColor': avatarBackgroundColor.toString(),
      'backgroundColor': stringToColor(backgroundColor.toString()),
    };

    return jsonEncode(json);
  }

  void handle() {}
}

class VideoCard {
  CardType type = CardType.video;
  int id;
  String name;
  String weChatNick;
  String avatar;
  Color backgroundColor;

  VideoCard(
      {required this.name,
      required this.id,
      required this.weChatNick,
      required this.avatar,
      required this.backgroundColor});

  VideoCard copyWith(
      {int? id,
      String? name,
      String? avatar,
      String? weChatNick,
      Color? backgroundColor}) {
    return VideoCard(
        id: id ?? this.id,
        name: name ?? this.name,
        weChatNick: weChatNick ?? this.weChatNick,
        avatar: avatar ?? this.avatar,
        backgroundColor: backgroundColor ?? this.backgroundColor);
  }

  factory VideoCard.fromJson(Map<String, dynamic> json) {
    return VideoCard(
      id: json['id'],
      name: json['name'],
      weChatNick: json['weChatNick'],
      avatar: json['avatar'],
      backgroundColor: stringToColor(json['backgroundColor']),
    );
  }

  String toJsonString() {
    final Map<String, dynamic> json = {
      'type': type.toString(),
      'id': id,
      'name': name,
      'avatar': avatar,
      'backgroundColor': backgroundColor.toString(),
    };

    return jsonEncode(json);
  }

  void handle() {}
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

  factory AppCard.fromJson(Map<String, dynamic> json) {
    return AppCard(
      id: json['id'],
      isInit: json['isInit'],
      packageName: json['packageName'],
      backgroundColor: stringToColor(json['backgroundColor']),
    );
  }

  String toJsonString() {
    final Map<String, dynamic> json = {
      'type': type.toString(),
      'id': id,
      'isInit': isInit,
      'packageName': packageName,
      'backgroundColor': backgroundColor.toString(),
    };

    return jsonEncode(json);
  }

  void handle() {
    DeviceApps.openApp(packageName);
  }
}
