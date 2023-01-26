import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/db/chat_operation_repo.dart';
import 'package:shared/shared.dart';

///
class ChatOperationRepoImpl implements ChatOperationRepo {
  ///
  ChatOperationRepoImpl(this._database, {this.collectionName});

  final Db _database;

  /// This is the [DbCollection] name
  final String? collectionName;

  DbCollection get _collection =>
      _database.collection(collectionName ?? 'chat_collection');

  @override
  Future<List<ChatModel>> getAllChats({required String room}) async {
    return (await _collection.find(where.eq('room', room)).toList())
        .asMap()
        .map((key, value) => MapEntry(key, ChatDto.fromJson(value).toModel()))
        .values
        .toList();
  }

  @override
  Future<void> insertChat({required ChatModel chat}) async {
    await _collection.insertOne(ChatDto.fromModel(chat).toJson());
  }
}
