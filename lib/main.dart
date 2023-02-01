import 'package:logging/logging.dart';
import 'package:reatime_chat/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final logger = Logger("Realtime-Chat-App-Logger");

void main() {
  dotenv.load(fileName: ".env");

  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen(
    (record) => debugPrint(
        '${record.loggerName}: ${record.level.name}: ${record.time}: ${record.message}'),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.grey,
      ),
      home: const App(),
    );
  }
}
