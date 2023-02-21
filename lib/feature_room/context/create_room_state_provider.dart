import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/room_repo.dart';
import './room_join_notifer.dart';

class CreateRoomStateNotifier extends StateNotifier<Resource<RoomModel>> {
  CreateRoomStateNotifier(this._repo) : super(Resource.loading());

  final RoomRepo _repo;
  final RoomJoinNotifier _notifier = RoomJoinNotifier();

  RoomJoinNotifier get joinRoomNotifier => _notifier;

  void _onSuccess(RoomModel data, String? _) => _notifier.allowJoin();

  void createRoom(int max) {
    _notifier.reset();
    _repo.createRoom(max).listen(
          (event) => state = event,
          onDone: () =>
              state.maybeWhen(success: _onSuccess, orElse: _notifier.reset),
          onError: (_) => _notifier.reset(),
        );
  }
}
