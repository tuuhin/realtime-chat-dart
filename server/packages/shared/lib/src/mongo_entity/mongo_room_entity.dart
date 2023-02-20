import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared/src/convertors/objectid_covertor.dart';
import 'package:shared/src/mongo_entity/base_entity.dart';

part 'mongo_room_entity.g.dart';

///These classes will be same as the dto object
@JsonSerializable(converters: [ObjectIdConvertor()])
class MongoRoomEntity extends BaseEntity {
  
  @JsonKey(name: "roomId")
  final String roomId;
  @JsonKey(name: "max")
  final int maxAttendes;
  @JsonKey(name: "count")
  final int count;

  MongoRoomEntity({
    required super.id,
    required this.roomId,
    required this.count,
    required this.maxAttendes,
  });

  factory MongoRoomEntity.fromJson(Map<String, dynamic> json) =>
      _$MongoRoomEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MongoRoomEntityToJson(this);
}
