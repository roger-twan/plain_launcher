import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/settings.dart';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeStream =
        Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    TimeFormatType timeFormatType =
        Provider.of<Settings>(context).timeFormatType;
    final List<String> twelveTimeFormat = [am, ' ', hh, ':', nn];
    final List<String> twentyFourTimeFormat = [HH, ':', nn];
    List<String> timeFormat = twentyFourTimeFormat;

    if (timeFormatType == TimeFormatType.twelve) {
      timeFormat = twelveTimeFormat;
    }

    return StreamBuilder<DateTime>(
      stream: _timeStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final DateTime time = snapshot.data!;
          final String formattedTime = formatDate(time, timeFormat);
          final String replacedTime =
              formattedTime.replaceAll('AM', '上午').replaceAll('PM', '下午');
          return Text(replacedTime);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
