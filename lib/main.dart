import 'package:flutter/material.dart';
import 'provider/card_list.dart';
import 'package:provider/provider.dart';
import 'provider/settings.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings().init();
  await CardList().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Settings()),
      ChangeNotifierProvider(create: (_) => CardList())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor:
              Provider.of<Settings>(context).backgroundColor,
          sliderTheme:
              SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
          textTheme: TextTheme(
              bodyMedium: TextStyle(
                  fontSize: Provider.of<Settings>(context).fontSize))),
      home: const HomePage(),
    );
  }
}
