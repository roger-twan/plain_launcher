import 'package:flutter/services.dart';

class ChannelService {
  static final ChannelService _instance = ChannelService._internal();
  factory ChannelService() => _instance;
  ChannelService._internal();

  final MethodChannel _channel = const MethodChannel('com.flutter.plain_launcher/channel');

  Future<void> openApp(String packageName, [bool restart = false]) async {
    await _channel.invokeMethod('openApp', {
      'packageName': packageName,
      'isRestart': restart
    });
  }
}
