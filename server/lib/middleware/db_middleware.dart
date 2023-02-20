import 'package:dart_frog/dart_frog.dart';
import 'package:dotenv/dotenv.dart';

import 'package:server/db/mongo_database.dart';
import 'package:server/respository/repository.dart';

final _monogURL = DotEnv().getOrElse(
  'MONGO_URL',
  () => 'mongodb://localhost:27017/realtime_chat_dart',
);

///The databse connector
final database = MongoDataBase(mongoURL: _monogURL);

/// [ChatOperationRepo] Provider Depedecy Injection
/// This provides the repository associtated with the chat functionality
Middleware chatProvider() {
  // Waiting for the connection state to complete
  return provider<ChatOperationRepo>(
    (context) => ChatOperationRepoImpl(database.db),
  );
}
