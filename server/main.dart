import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/mongo_database.dart';

final _database =
    MongoDataBase(mongoURL: 'mongodb://localhost:27017/realtime_chat_dart');

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  /// Initlizing the database coneection over here
  /// The database connection can be made via middle ware but
  /// the middleware are register before this function  thus finding the
  /// provider up the tree is not possible.
  /// So we are initlizing the [MongoDataBase] connection over here

  await _database.init();

  /// The main app runs from here
  return serve(handler, ip, port);
}
