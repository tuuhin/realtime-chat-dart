import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/db/chat_operation_repo.dart';
import 'package:shared/shared.dart';

/// ChatOperations with associated mongodb
class ChatOperationRepoImpl implements ChatOperationRepo {
  /// [ChatOperationRepoImpl] provied the method implementaion of the methods
  /// mentioned in the [ChatOperationRepo]
  ChatOperationRepoImpl(this._dataBase, {this.collectionName});

  final Db _dataBase;

  /// This is the [DbCollection] name which will be of type [String] in case
  /// the name is found missing then use a custom name chat_collection
  final String? collectionName;

  DbCollection get _collection =>
      _dataBase.collection(collectionName ?? 'chat_collection');

  @override
  Future<List<ChatModel>> getAllChats({required String room}) async {
    return (await _collection.find(where.eq('room', room)).toList())
        .asMap()
        .map(
          (key, value) => MapEntry(key, ChatDto.fromJson(value).toModel()),
        )
        .values
        .toList();
  }

  @override
  Future<void> insertChat({required ChatModel chat}) async {
    final result = await _collection.insertOne(
      NewChatDto.fromModel(chat).toJson(),
    );
    ChatDto.fromJson(result.document!).toModel();
  }

  @override
  Stream streamChats({required String room}) => _collection.find();

  @override
  Future<void> deleteChat({required String hexString}) async {
    await _collection.deleteOne(
      where.eq('_id', ObjectId.fromHexString(hexString)),
    );
  }
}
