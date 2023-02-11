import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reatime_chat/feature_room/context/create_room_state_provider.dart';
import 'package:reatime_chat/main.dart';
import 'package:shared/shared.dart';

import '../data/room_api.dart';
import '../data/room_repo_impl.dart';
import '../repository/room_repo.dart';
import 'check_room_state_provider.dart';
import 'room_join_notifer.dart';

final _roomApi = Provider<RoomApi>((ref) => RoomApi());

final _roomprovider = Provider<RoomRepo>(
  (ref) => RoomRepoImpl(ref.read<RoomApi>(_roomApi)),
);

final _roomJoinProvider = ChangeNotifierProvider((ref) => RoomJoinNotifier());

final checkRoomStateProvider = StateNotifierProvider.autoDispose
    .family<CheckRoomStateNotifier, Resource<CheckRoomModel?>, String>(
  (ref, room) {
    ref.onDispose(() => logger
        .finer("Check room provider with roomId:$room has been disposed"));
    final request = CheckRoomStateNotifier(
      ref.read(_roomprovider),
      ref.read(_roomJoinProvider),
    )..checkRoom(room: room);
    ref.keepAlive();
    return request;
  },
);

final createRoomStateProvider = StateNotifierProvider.autoDispose
    .family<CreateRoomStateNotifier, Resource<RoomModel>, int>((ref, maxCount) {
  ref.onDispose(() => logger.finer(
      "Creating room provider with maxcount:$maxCount has been disposed"));
  final request = CreateRoomStateNotifier(
    ref.read(_roomprovider),
    ref.read(_roomJoinProvider),
  )..createRoom(maxCount);
  ref.keepAlive();
  return request;
});
