import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return CheckRoomStateNotifier(
      ref.read(_roomprovider),
      ref.read(_roomJoinProvider),
    )..checkRoom(room: room);
  },
);
