import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ObjectIdConvertor extends JsonConverter<ObjectId, String> {
  const ObjectIdConvertor();

  @override
  fromJson(String json) => ObjectId.fromHexString(json);

  @override
  toJson(ObjectId object) => object.$oid;
}
