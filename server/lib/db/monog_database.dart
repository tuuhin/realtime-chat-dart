import 'package:mongo_dart/mongo_dart.dart';

/// This is the mongo database for storing the chat data
class MongoDataBase {
  ///
  MongoDataBase({required this.mongoURL});

  ///
  final String mongoURL;
  late final Db _dataBase;

  /// The getter for the db
  Db get db => _dataBase;

  ///This inilizes the database
  Future<void> init() async {
    _dataBase = Db(mongoURL);
    await _dataBase.open();
  }
}
