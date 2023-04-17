class ServerException implements Exception {
  final String? message;
  ServerException({this.message = 'Server error'});
  @override
  String toString() {
    return message ?? 'Server error';
  }
}

class NotFoundException implements Exception {}

class BadRequestException implements Exception {}

class NetworkException implements Exception {}

class UndefinedException implements Exception {}

class CacheException implements Exception {}


// import 'package:dio/dio.dart';

// class CacheException implements Exception {}

// class BadRequestException extends DioError {
//   BadRequestException(RequestOptions r) : super(requestOptions: r);
// }

// class InternalServerErrorException extends DioError {
//   InternalServerErrorException(RequestOptions r) : super(requestOptions: r);
// }

// class ConflictException extends DioError {
//   ConflictException(RequestOptions r) : super(requestOptions: r);
// }

// class UnauthorizedException extends DioError {
//   UnauthorizedException(RequestOptions r) : super(requestOptions: r);
// }

// class NotFoundException extends DioError {
//   NotFoundException(RequestOptions r) : super(requestOptions: r);
// }

// class NoInternetConnectionException extends DioError {
//   NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);
// }

// class DeadlineExceededException extends DioError {
//   DeadlineExceededException(RequestOptions r) : super(requestOptions: r);
// }
