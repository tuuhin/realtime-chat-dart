import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/chat_operation_repo.dart';
import 'package:server/db/chat_operation_repo_impl.dart';
import 'package:server/db/monog_database.dart';

final _dataBase =
    MongoDataBase(mongoURL: 'mongodb://localhost:27017/mongo_dart-blog')
      ..init();

///
Middleware dataBaseProvider() => provider<ChatOperationRepo>(
      (_) => ChatOperationRepoImpl(_dataBase.db, collectionName: 'chat_me'),
    );
