import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/db/room/room_operations_repo.dart';
import 'package:shared/shared.dart';

///
class RoomOperaionRepoImpl implements RoomOperations {
  ///
  RoomOperaionRepoImpl(this._dataBase, {this.collectionName});

  final Db _dataBase;

  /// This is the [DbCollection] name which will be of type [String] in case
  /// the name is found missing then use a custom name chat_collection
  final String? collectionName;

  DbCollection get _collection =>
      _dataBase.collection(collectionName ?? 'room_collection');

  Future<List<String>> _getRoomId() async => _collection
      .find()
      .asyncMap(
        (event) => RoomDto.fromEntity(MongoRoomEntity.fromJson(event)).roomId,
      )
      .toList();

  @override
  Future<CheckRoomModel?> checkRoom({required String room}) async {
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
}
