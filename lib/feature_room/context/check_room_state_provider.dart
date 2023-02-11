import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reatime_chat/main.dart';

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

    _repo.checkRoom(room).listen(
      (event) => state = event,
      onDone: () {
        state.maybeWhen(
          success: (data, __) => data?.state == RoomState.joinable
              ? _notifier.allowJoin()
              : _notifier.reset(),
          orElse: () => _notifier.reset(),
        );
        logger.fine(_notifier.allowed);
      },
    );
  }
}
