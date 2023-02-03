import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';

@freezed
class Resource<T> with _$Resource<T> {
  factory Resource.success({required T data, String? message}) = _Data;
  factory Resource.failed({required String message, Object? err, T? data}) =
      _Error;
  factory Resource.loading({String? message, T? data}) = _Loading;
}
