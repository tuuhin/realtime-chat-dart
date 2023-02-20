import 'package:dotenv/dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/respository/repository.dart';
import 'package:shared/shared.dart';

/// ChatOperations with associated mongodb
class ChatOperationRepoImpl implements ChatOperationRepo {
  /// [ChatOperationRepoImpl] provied the method implementaion of the methods
  /// mentioned in the [ChatOperationRepo]
  ChatOperationRepoImpl(this._dataBase);

  final Db _dataBase;

  /// This is the [DbCollection] name which will be of type [String] in case
  /// the name is found missing then use a custom name chat_collection
  DbCollection get _collection => _dataBase.collection(
        DotEnv().getOrElse('COLLECTION_NAME_CHATS', () => 'chat_me'),
      );

  @override
  Future<List<ChatModel>> getAllChats({required String room}) async {
    return (await _collection.find(where.eq('room', room)).toList())
        .map(
          (json) =>
              ChatDto.fromEntity(MongoChatEntity.fromJson(json)).toModel(),
        )
        .toList();
  }

  @override
  Future<ChatModel> insertChat({required ChatModel chat}) async {
    final result = await _collection.insertOne(
      NewChatDto.fromModel(chat).toJson(),
    );

    return ChatDto.fromEntity(MongoChatEntity.fromJson(result.document!))
        .toModel();
  }

  /// This method was meant to stream the data changes in the mongo database
  /// could not find a proper way to get the data or I am not understanding
  /// how to take the data thus marking is [Deprecated]
  @override
  @Deprecated('Incomplete method cannot be used')
  Stream<ChatModel> streamChats({required String room}) async* {
    // yields the previous data from the stream
    yield* Stream.fromIterable(await getAllChats(room: room));
    //yields the current data from the stream

    //   final pipeLine = AggregationPipelineBuilder()
    //       .addStage(Match(where.eq('room', room).map[r'$query']))
    //       .build();

    //   final stream = _collection
    //       .watch(
    //         pipeLine,
    //         changeStreamOptions:
    //             ChangeStreamOptions(fullDocument: 'updateLookup'),
    //       )
    //       .cast<List<Map<String, dynamic>>>()
    //       .asyncMap((event) => null);

    //   stream.listen((event) {
    //     print(event);
    //   });
  }

  @override
  Future<void> deleteChat({required ChatModel chat}) async => chat.id != null
      ? _collection.deleteOne(
          where.eq('_id', ObjectId.fromHexString(chat.id!)),
        )
      : null;
}
