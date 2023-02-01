import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/room_api.dart';
import 'data/room_repo_impl.dart';
import 'repository/room_repo.dart';

final _roomApi = Provider<RoomApi>((ref) => RoomApi());

final roomprovider = Provider<RoomRepo>(
  (ref) => RoomRepoImpl(ref.read<RoomApi>(_roomApi)),
);
