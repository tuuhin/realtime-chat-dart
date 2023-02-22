import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './router.dart';
import './theme/palette.dart';

final logger = Logger("Realtime-Chat-App-Logger");
void main() {
  dotenv.load(fileName: ".env");

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen(
    (record) => debugPrint(
        '${record.loggerName} => ${record.level.name}: ${record.time}: ${record.message}'),
  );
  setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
        builder: (ColorScheme? light, ColorScheme? dark) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          darkTheme: dark != null
              ? ThemeData(
                  useMaterial3: true,
                  typography:
                      Typography.material2021(platform: defaultTargetPlatform),
                  colorScheme: dark)
              : darkTheme,
          theme: light != null
              ? ThemeData(
                  useMaterial3: true,
                  typography:
                      Typography.material2021(platform: defaultTargetPlatform),
                  colorScheme: light)
              : lightTheme,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
        ),
      );
}
