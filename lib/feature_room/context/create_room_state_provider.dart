import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../repository/room_repo.dart';
import 'room_join_notifer.dart';

class CreateRoomStateNotifier extends StateNotifier<Resource<RoomModel>> {
  CreateRoomStateNotifier(this._repo, this._notifier)
      : super(Resource.loading());
  final RoomRepo _repo;
  final RoomJoinNotifier _notifier;

  RoomJoinNotifier get joinRoomNotifier => _notifier;

  void createRoom(int max) =>
      _repo.createRoom(max).listen((event) => state = event, onDone: () {
        state.maybeWhen(
          success: (data, __) => _notifier.allowJoin(),
          orElse: () => _notifier.reset(),
        );
        logger.fine(_notifier.allowed);
      });
}
