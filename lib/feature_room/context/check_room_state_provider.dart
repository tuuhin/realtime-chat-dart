import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared/shared.dart';

import '../repository/room_repo.dart';
import 'room_join_notifer.dart';

class CheckRoomStateNotifier extends StateNotifier<Resource<CheckRoomModel?>> {
  CheckRoomStateNotifier(this._repo, this._notifier)
      : super(Resource.loading());

  final RoomRepo _repo;
  final RoomJoinNotifier _notifier;

  RoomJoinNotifier get joinRoomNotifier => _notifier;

  void checkRoom({required String room}) {
    // Clears the able to join the room
    _notifier.dontAllowJoin();
    _repo.checkRoom(room).listen(
      (event) {
        state = event;
        event.whenOrNull(
          // Allowing to join the chat
          success: (data, message) => _notifier.allowJoin(),
        );
      },
    );
  }
}
