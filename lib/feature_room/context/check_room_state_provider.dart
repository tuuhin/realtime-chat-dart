import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './room_join_notifer.dart';
import '../repository/room_repo.dart';

class CheckRoomStateNotifier extends StateNotifier<Resource<CheckRoomModel>> {
  CheckRoomStateNotifier(this._repo) : super(Resource.loading());

  final RoomRepo _repo;
  final RoomJoinNotifier _notifier = RoomJoinNotifier();

  RoomJoinNotifier get joinRoomNotifier => _notifier;

  void _onSuccess(CheckRoomModel data, String? _) =>
      data.state == RoomState.joinable ? _notifier.allowJoin() : null;

  void checkRoom({required String room}) {
    // Clears the able to join the room
    _notifier.reset();

    _repo.checkRoom(room).listen((event) => state = event,
        onDone: () =>
            state.maybeWhen(success: _onSuccess, orElse: _notifier.reset),
        onError: (_) => _notifier.reset());
  }
}
