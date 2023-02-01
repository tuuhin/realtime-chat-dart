import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../repository/room_repo.dart';
import './room_api.dart';

class RoomRepoImpl implements RoomRepo {
  final RoomApi _api;

  RoomRepoImpl(this._api);

  @override
  Stream<Resource<RoomModel?>> checkRoom(String room) async* {
    yield Resource.loading(message: "CHECKING YOUR ROOM");
    try {
      RoomDto dto = await _api.createRoom();
      yield Resource.success(
          data: dto.toModel(), message: "Your room id has benn created");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }

  @override
  Stream<Resource<RoomModel>> createRoom() async* {
    yield Resource.loading(message: "CREATING YOUR ROOM");
    try {
      RoomDto dto = await _api.createRoom();
      yield Resource.success(
          data: dto.toModel(), message: "Your room id has benn created");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      yield Resource.failed(message: e.toString(), err: e);
    }
  }
}
