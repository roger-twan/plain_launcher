import 'package:flutter/material.dart';

Color stringToColor(String str) {
  final String valueString = str.split('(0x')[1].split(')')[0];
  final int value = int.parse(valueString, radix: 16);

  return Color(value);
}
