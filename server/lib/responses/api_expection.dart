import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// Some helpers created via [Response]. Which will later help to speed up the \
/// reponses definations
class ApiException extends Response {
  ///The base class
  ApiException({
    required this.details,
    this.status = HttpStatus.noContent,
  }) : super(
          body: jsonEncode({'details': details}),
          statusCode: status,
        );

  /// [HttpStatus.badRequest] Method Implementation
  factory ApiException.badRequest({required String details}) =>
      ApiException(details: details, status: HttpStatus.badRequest);

  /// [HttpStatus.notFound] Method Implementation
  factory ApiException.notFound({required String details}) =>
      ApiException(details: details, status: HttpStatus.badRequest);

  /// [HttpStatus.failedDependency] Method Implementation
  factory ApiException.failedDependency({required String details}) =>
      ApiException(details: details, status: HttpStatus.failedDependency);

  /// The [Response] body of the request
  final String details;

  /// The [HttpStatus] for the request
  final int status;
}
