import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TimeFormatType { twelve, twentyFour }

class Settings extends ChangeNotifier {
  static final Settings _instance = Settings._internal();
  factory Settings() => _instance;
  Settings._internal();

  late SharedPreferences? _preferences;
  TimeFormatType _timeFormatType = TimeFormatType.twelve;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _initTimeFormatType();
  }

  // time format type
  void _initTimeFormatType() {
    String savedTimeFormatType =
        _preferences?.getString('timeFormatType') ?? _timeFormatType.toString();
    if (savedTimeFormatType == TimeFormatType.twelve.toString()) {
      _timeFormatType = TimeFormatType.twelve;
    } else if (savedTimeFormatType == TimeFormatType.twentyFour.toString()) {
      _timeFormatType = TimeFormatType.twentyFour;
    }
  }

  TimeFormatType get timeFormatType => _timeFormatType;
  Future<void> setTimeFormatType(TimeFormatType timeFormatType) async {
    _timeFormatType = timeFormatType;
    await _preferences?.setString('timeFormatType', timeFormatType.toString());
    notifyListeners();
  }
}
