import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/settings.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Settings().init();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Settings())],
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
