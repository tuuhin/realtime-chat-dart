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
      .asyncMap((event) => RoomDto.fromJson(event).roomId)
      .toList();

  @override
  Future<RoomModel?> checkRoom(String room) async {
    final result = await _collection.findOne(where.eq('roomId', room));
    if (result == null) return null;
    return RoomDto.fromJson(result).toModel();
  }

  @override
  Future<RoomModel> createRoom() async {
    final roomId = createRoomId(await _getRoomId());

    final result = await _collection.insertOne({'roomId': roomId});

    return RoomDto.fromJson(result.document!).toModel();
  }
}
