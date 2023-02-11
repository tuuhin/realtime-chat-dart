import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CreateRoomViewer extends StatelessWidget {
  final void Function()? onCopy;
  final RoomModel data;
  const CreateRoomViewer({Key? key, this.onCopy, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text(
        //   "Room created successfully",
        //   style: Theme.of(context).textTheme.labelLarge,
        // ),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.roomId,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  IconButton(
                    tooltip: "COPY THE ROOM ID TO CLIPBOARD",
                    onPressed: onCopy,
                    icon: const Icon(Icons.copy),
                  )
                ],
              ),
              const Divider(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Room details",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  )),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Max Attendes count ${data.maxAttendes}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
