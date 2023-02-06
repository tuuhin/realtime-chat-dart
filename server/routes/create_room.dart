import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:server/db/room/room_operations_repo.dart';
import 'package:server/responses/api_expection.dart';
import 'package:shared/shared.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: HttpStatus.methodNotAllowed);
  }
  final body = await context.request.json();
  if (body is! Map<String, dynamic>) {
    return ApiException.badRequest(details: 'Invalid data format');
  }
  if (!body.containsKey('max')) {
    return ApiException.badRequest(details: 'Max attendes are not provided');
  }

  final maxAttendes = body['max'] as int;
  final resp =
      await context.read<RoomOperations>().createRoom(max: maxAttendes);

  return Response.json(body: RoomDto.fromModel(resp).toJson());
}
