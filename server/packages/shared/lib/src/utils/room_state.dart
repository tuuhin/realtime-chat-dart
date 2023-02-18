///RoomState for check room data
enum RoomState {
  ///[MongoRoomEntity] found
  /// But the count equals to max so no more members are allowed
  full,

  ///[MongoRoomEntity] found
  /// The count for the number of participants is lesser than that of max
  joinable,

  /// [MongoRoomEntity] is undefined
  /// There is no room with the provided details
  undefined
}

enum ChatOwner { self, other, server, client }
