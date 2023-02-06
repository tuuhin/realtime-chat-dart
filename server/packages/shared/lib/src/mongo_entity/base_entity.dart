import 'package:mongo_dart/mongo_dart.dart';
import 'package:json_annotation/json_annotation.dart';

/// All MongoDatabase fields have a [ObjectId] field thus this field is common
/// to the Entities.
/// The additional creation for the [BaseEntity] thus Entities due to the clash
/// of ObjectId Conversion.
abstract class BaseEntity {
  /// The [ObjectId] for MongoDataBase
  @JsonKey(name: "_id")
  final ObjectId id;
  BaseEntity({required this.id});
}
