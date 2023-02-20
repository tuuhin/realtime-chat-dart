import 'dart:developer';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:logging/logging.dart';
import 'package:server/db/mongo_database.dart';

final _database =
    MongoDataBase(mongoURL: 'mongodb://localhost:27017/realtime_chat_dart');

final logger = Logger('SERVER_LOGGER');

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  /// Initlizing the database coneection over here
  /// The database connection can be made via middle ware but
  /// the middleware are register before this function  thus finding the
  /// provider up the tree is not possible.
  /// So we are initlizing the [MongoDataBase] connection over here

  await _database.init();

  logger.onRecord.listen(
    (record) => log(
      '${record.level.name}: ${record.time}: ${record.message}',
      level: record.level.value,
      name: record.loggerName,
      sequenceNumber: record.sequenceNumber,
      time: record.time,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    ),
  );

  /// The main app runs from here
  return serve(handler, ip, port);
}
