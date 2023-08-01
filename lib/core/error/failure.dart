// import 'package:equatable/equatable.dart';

// abstract class Failure extends Equatable {
//   const Failure({this.message, this.code});
//   final String? message;
//   final int? code;
//   @override
//   List<Object?> get props => [message, code];
// }

// class ServerFailure extends Failure {
//   const ServerFailure()
//       : super(
//             message: 'Unknown error occurred, please try again later.',
//             code: 500);
// }

// class BadRequestFailure extends Failure {
//   const BadRequestFailure() : super(message: 'Invalid request', code: 400);
// }

// class NotFoundFailure extends Failure {
//   const NotFoundFailure()
//       : super(
//             message: 'The requested information could not be found', code: 404);
// }

// class ConflictFailure extends Failure {
//   const ConflictFailure() : super(message: 'Conflict occurred', code: 409);
// }

// class UnauthorizedFailure extends Failure {
//   const UnauthorizedFailure() : super(message: 'Access denied', code: 401);
// }

// class NoInternetConnectionFailure extends Failure {
//   const NoInternetConnectionFailure()
//       : super(message: 'No internet connection detected, please try again');
// }

// class DeadlineExceededFailure extends Failure {
//   const DeadlineExceededFailure()
//       : super(message: 'The connection has timed out, please try again.');
// }

// class CacheFailure extends Failure {
//   const CacheFailure() : super(message: 'Cache error');
// }

// class UndefinedFailure extends Failure {
//   final String message;

//   const UndefinedFailure({required this.message}) : super(message: message);
// }

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.message, this.code});
  final String? message;
  final int? code;
  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  final String? info;
  const ServerFailure({this.info})
      : super(message: info ?? 'Erreur de serveur', code: 500);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({String? message, int? code})
      : super(message: message ?? 'Bad request', code: 400);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super(message: 'Not found', code: 404);
}

class CacheFailure extends Failure {
  const CacheFailure() : super(message: 'Cache error');
}

class NoConnexionFailure extends Failure {
  const NoConnexionFailure() : super(message: 'Pas d\'accès internet');
}

class UnprocessableContentFailure extends Failure {
  const UnprocessableContentFailure({String? message, int? code})
      : super(message: message ?? 'Unprocessable content', code: 422);
}

class WarningWordFailure extends Failure {
  const WarningWordFailure() : super(message: 'Un mot interdit prononcé');
}
