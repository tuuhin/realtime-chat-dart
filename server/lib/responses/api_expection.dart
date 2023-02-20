import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// Some helpers created via [Response]. Which will later help to speed up the
/// reponses definations
class ApiException extends Response {
  ///The Base class for creating [ApiException]
  ApiException._({
    required this.details,
    this.status = HttpStatus.noContent,
  }) : super(
          body: jsonEncode({'details': details}),
          statusCode: status,
        );

  /// [HttpStatus.badRequest] Method Implementation\
  /// Error Code: `400`
  factory ApiException.badRequest({required String details}) =>
      ApiException._(details: details, status: HttpStatus.badRequest);

  /// [HttpStatus.notFound] Method Implementation\
  /// Error Code :`404`
  factory ApiException.notFound({required String details}) =>
      ApiException._(details: details, status: HttpStatus.notFound);

  ///[HttpStatus.expectationFailed] condition\
  ///Error code :`417`
  factory ApiException.exceptationFailed({required String details}) =>
      ApiException._(details: details, status: HttpStatus.expectationFailed);

  /// [HttpStatus.failedDependency] Method Implementation \
  /// Error Code : `417`
  factory ApiException.failedDependency({required String details}) =>
      ApiException._(details: details, status: HttpStatus.preconditionFailed);

  /// The [Response] body of the request
  final String details;

  /// The [HttpStatus] for the request
  final int status;
}
