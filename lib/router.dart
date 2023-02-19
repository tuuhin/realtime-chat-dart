import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import 'feature_chat/chats.dart';
import 'feature_room/rooms.dart';

import 'feature_room/ui/routes/room_routes.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Rooms(),
    ),
    GoRoute(
      path: '/join-room',
      builder: (context, state) => const JoinRoomRoute(),
    ),
    GoRoute(
        path: '/create-room',
        builder: (context, state) => const CreateRoomRoute()),
    GoRoute(
      path: '/chats',
      builder: (context, state) => Chats(room: state.extra as RoomModel),
    ),
  ],
);
