import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ObjectIdConvertor extends JsonConverter<ObjectId, ObjectId> {
  const ObjectIdConvertor();

  @override
  fromJson(ObjectId json) => json;

  @override
  toJson(ObjectId object) => object;
}
