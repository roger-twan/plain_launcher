import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../const/weekday.dart';
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
    final List<String> dateFormat = [m, '月', dd, '日'];
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
          final String formattedDate = formatDate(time, dateFormat);
          final String formattedTime = formatDate(time, timeFormat);
          final String weekdayEN = formatDate(time, [DD]);
          final String weekDayCN = weekDayMap[weekdayEN]!;
          final String replacedTime =
              formattedTime.replaceAll('AM', '上午').replaceAll('PM', '下午');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$formattedDate $weekDayCN',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: Colors.black,
                      )
                    ]),
              ),
              Text(
                replacedTime,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        Theme.of(context).textTheme.bodyMedium!.fontSize! * 1.2,
                    shadows: const <Shadow>[
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        color: Colors.black,
                      )
                    ]),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
