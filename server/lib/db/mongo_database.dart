import 'package:mongo_dart/mongo_dart.dart';

/// This is the mongo database for storing the chat data
class MongoDataBase {
  ///[MongoDataBase] helps to make a connetion to the mongodb database instance
  ///via [mongoURL]
  MongoDataBase({required this.mongoURL});

  /// [mongoURL] is the mongoURL that is used to connect to the database
  final String mongoURL;
  static late final Db _dataBase;

  bool _isInit = false;

  /// The getter for the db
  Db get db => _dataBase;

  ///This inilizes the database
  Future<void> init() async {
    // If the database is already initilized then no need to re-initilize it

    if (_isInit) return;
    _dataBase = Db(mongoURL);
    _isInit = true;
    // Checking for the connection state
    if (_dataBase.state != State.open || _dataBase.state != State.opening) {
      print('OPENING DATABASE');
      await _dataBase.open();
      print("OPENDED DATABASE");
    }
  }

  /// Closes the opened database
  void close() => _isInit ? _dataBase.close() : null;
}
