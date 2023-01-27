import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/db.dart';

final _database =
    MongoDataBase(mongoURL: 'mongodb://localhost:27017/realtime_chat_dart');

/// [ChatOperationRepo] Provider
/// This provides the functions associtated with the chat functionality
Middleware chatProvider() {
  // Waiting for the connection state to complete

  return provider<ChatOperationRepo>(
    (_) => ChatOperationRepoImpl(_database.db, collectionName: 'chat_me'),
  );
}
