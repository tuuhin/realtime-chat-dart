import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../repository/room_repo.dart';
import './room_api.dart';

class RoomRepoImpl implements RoomRepo {
  final RoomApi _api;

  RoomRepoImpl(this._api);

  @override
  Stream<Resource<CheckRoomModel?>> checkRoom(String room) async* {
    yield Resource.loading(message: "CHECKING YOUR ROOM");
    await Future.delayed(const Duration(seconds: 2));
    try {
      CheckRoomDto dto = await _api.checkRoom(room);
      yield Resource.success(data: dto.toModel());
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }

  @override
  Stream<Resource<RoomModel>> createRoom(int max) async* {
    yield Resource.loading(message: "CREATING YOUR ROOM");
    try {
      RoomDto dto = await _api.createRoom(max);
      yield Resource.success(
          data: dto.toModel(), message: "Your room id has benn created");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }
}
