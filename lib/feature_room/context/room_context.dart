import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared/shared.dart';

import '../../main.dart';
import '../data/room_api.dart';
import '../data/room_repo_impl.dart';
import '../repository/room_repo.dart';
import './check_room_state_provider.dart';
import './create_room_state_provider.dart';

final _roomApi = Provider<RoomApi>((ref) => RoomApi());

final _roomprovider = Provider<RoomRepo>(
  (ref) => RoomRepoImpl(ref.read<RoomApi>(_roomApi)),
);

final checkRoomStateProvider = StateNotifierProvider.autoDispose
    .family<CheckRoomStateNotifier, Resource<CheckRoomModel?>, String>(
  (ref, room) {
    ref.onDispose(
      () => logger
          .shout("Check room provider with roomId:$room has been disposed"),
    );

    return CheckRoomStateNotifier(ref.read(_roomprovider))
      ..checkRoom(room: room);
  },
);

final createRoomStateProvider = StateNotifierProvider.autoDispose
    .family<CreateRoomStateNotifier, Resource<RoomModel>, int>((ref, maxCount) {
  ref.onDispose(
    () => logger.shout(
        "Creating room provider with maxcount:$maxCount has been disposed"),
  );

  return CreateRoomStateNotifier(ref.read(_roomprovider))..createRoom(maxCount);
});
