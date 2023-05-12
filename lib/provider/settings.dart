import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TimeFormatType { twelve, twentyFour }

class Settings extends ChangeNotifier {
  static final Settings _instance = Settings._internal();
  factory Settings() => _instance;
  Settings._internal();

  late SharedPreferences? _preferences;
  TimeFormatType _timeFormatType = TimeFormatType.twelve;
  double _fontSize = 20;
  int _eachRowCount = 3;
  Color _backgroundColor = Colors.white;
  bool _isCardEditing = false;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _initTimeFormatType();
    _initFontSize();
    _initEachRowCount();
    _initBackgroundColor();
  }

  // time format type
  void _initTimeFormatType() {
    final String savedTimeFormatType =
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

  // font size
  void _initFontSize() {
    _fontSize = _preferences?.getDouble('fontSize') ?? _fontSize;
  }

  double get fontSize => _fontSize;
  Future<void> setFontSize(double fontSize) async {
    _fontSize = fontSize;
    await _preferences?.setDouble('fontSize', fontSize);
    notifyListeners();
  }

  // each row count
  void _initEachRowCount() {
    _eachRowCount = _preferences?.getInt('eachRowCount') ?? _eachRowCount;
  }

  int get eachRowCount => _eachRowCount;
  Future<void> setEachRowCount(int eachRowCount) async {
    _eachRowCount = eachRowCount;
    await _preferences?.setInt('eachRowCount', eachRowCount);
    notifyListeners();
  }

  // background color
  void _initBackgroundColor() {
    final String savedBackgroundColor =
        _preferences?.getString('backgroundColor') ??
            _backgroundColor.toString();
    final String valueString =
        savedBackgroundColor.split('(0x')[1].split(')')[0];
    final int value = int.parse(valueString, radix: 16);
    _backgroundColor = Color(value);
  }

  Color get backgroundColor => _backgroundColor;
  Future<void> setBackgroundColor(Color backgroundColor) async {
    _backgroundColor = backgroundColor;
    await _preferences?.setString(
        'backgroundColor', backgroundColor.toString());
    notifyListeners();
  }

  // card editing
  bool get isCardEditing => _isCardEditing;
  void setIsCardEditing(bool isCardEditing) {
    _isCardEditing = isCardEditing;
    notifyListeners();
  }
}
