import 'package:dotenv/dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/db/mongo_database.dart';
import 'package:server/respository/room/room_operations_repo.dart';
import 'package:shared/shared.dart';

/// [RoomOperationRepoImpl] implements [RoomOperations] methods and provides
/// there respective return types
class RoomOperationRepoImpl implements RoomOperations {
  /// [RoomOperationRepoImpl] takes the [MongoDataBase] instance for performing
  /// queries
  /// - Creating room
  /// - Updating room count
  /// - Checking the availabilty of the room
  RoomOperationRepoImpl(this._dataBase);

  final Db _dataBase;

  /// This is the [DbCollection] name which will be of type [String] in case
  /// the name is found missing then use a custom name chat_collection
  DbCollection get _collection => _dataBase.collection(
        DotEnv().getOrElse('COLLECTION_NAME_ROOM', () => 'rooms'),
      );

  /// Gets the all the room Id present in the database this helps to create
  /// a new unique room id that is not present
  Future<List<String>> _getRoomId() async => _collection
      .find()
      .asyncMap(
        (event) => RoomDto.fromEntity(MongoRoomEntity.fromJson(event)).roomId,
      )
      .toList();

  @override
  Future<CheckRoomModel> checkRoom({required String room}) async {
    final result = await _collection.findOne(where.eq('roomId', room));
    if (result == null) return CheckRoomModel(state: RoomState.undefined);
    final model =
        RoomDto.fromEntity(MongoRoomEntity.fromJson(result)).toModel();
    if (model.count == model.maxAttendes) {
      return CheckRoomModel(state: RoomState.full, room: model);
    }
    return CheckRoomModel(state: RoomState.joinable, room: model);
  }

  @override
  Future<RoomModel> createRoom({required int max}) async {
    final roomId = createRoomId(await _getRoomId());

    final result = await _collection.insertOne(
      CreateRoomDto(roomId: roomId, maxAttendes: max).toJson(),
    );

    return RoomDto.fromEntity(MongoRoomEntity.fromJson(result.document!))
        .toModel();
  }

  @override
  Future<void> updateRoom({
    required String room,
    required int newCount,
  }) async =>
      _collection.updateOne(
        where.eq('roomId', room),
        modify.set('count', newCount),
      );
}
