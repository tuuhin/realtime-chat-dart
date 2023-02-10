import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class RoomModelViewer extends StatelessWidget {
  final CheckRoomModel roomModel;
  const RoomModelViewer({super.key, required this.roomModel});

  String get typeToString {
    switch (roomModel.state) {
      case RoomState.full:
        return "ROOM FULL";
      case RoomState.joinable:
        return "ROOM JOINABLE";
      case RoomState.undefined:
        return "ROOM NOT FOUND";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          typeToString,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        if (roomModel.room != null) ...[
          Text("Joined: ${roomModel.room!.count}"),
          Text("Maximum: ${roomModel.room!.maxAttendes}")
        ]
      ],
    );
  }
}
