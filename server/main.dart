import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/mongo_database.dart';

final _database =
    MongoDataBase(mongoURL: 'mongodb://localhost:27017/realtime_chat_dart');

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  //Initlizing the database coneection over here
  await _database.init();

  return serve(handler, ip, port);
}
