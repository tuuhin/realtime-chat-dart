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
        if (roomModel.state == RoomState.undefined) ...[
          const SizedBox(height: 2),
          Text(
            'Room dont exists create a new one ',
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
        const SizedBox(height: 10),
        if (roomModel.room != null)
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Joined: ${roomModel.room!.count}"),
                  Text("Maximum: ${roomModel.room!.maxAttendes}")
                ],
              ),
            ),
          )
      ],
    );
  }
}
