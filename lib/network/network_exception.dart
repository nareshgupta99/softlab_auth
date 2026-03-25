import 'package:softlab_auth/utils/local_message.dart';

class NetworkException implements Exception {
  final dynamic prefix;
  final dynamic exception;
  NetworkException([this.exception, this.prefix]);

  @override
  String toString() => "$prefix$exception";
}

class FetchNetworkException extends NetworkException {
  FetchNetworkException([String? message]) : super(message, '');
}

class ForbiddenException extends NetworkException {
  ForbiddenException([String? message]) : super(message, '');
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException([String? message]) : super(message, '');
}

class BadRequest400Exception extends NetworkException {
  BadRequest400Exception([String? message]) : super(message, '');
}

class ResourceNotFoundException extends NetworkException {
  ResourceNotFoundException([String? message]) : super(message, '');
}

enum Exceptions {
  handShakeError,
  timedOutOrNoInternet,
  unPreocessableResponse,
  badRequest400,
  unauthorized401,
  forbidden403,
  requestNotFound404,
  methodNotAllowd405,
  conflictInRequest409,
  serverError500,
  serviceUnavailable503,
  unknownError000,
}

Map<Exceptions, String> exceptionRawValues = {
  Exceptions.handShakeError: LocalMessages.handshakeException,
  Exceptions.unPreocessableResponse: LocalMessages.unProcessableResponse,
  Exceptions.timedOutOrNoInternet: LocalMessages.timedOutOrNoInternet,
  // --- --- --- --- [STATUS CODE EXCEPTIONS] --- --- --- --- //
  Exceptions.badRequest400: LocalMessages.badRequestException,
  Exceptions.unauthorized401: LocalMessages.unauthorizedException,
  Exceptions.forbidden403: LocalMessages.forbiddenException,
  Exceptions.requestNotFound404: LocalMessages.requestNotFoundException,
  Exceptions.methodNotAllowd405: LocalMessages.methodNotAllowedException,
  Exceptions.conflictInRequest409: LocalMessages.conflictInRequestException,
  Exceptions.serverError500: LocalMessages.serverErrorException,
  Exceptions.serviceUnavailable503: LocalMessages.serviceUnavailableExceeption,
  Exceptions.unknownError000: LocalMessages.unknownErrorException,
};
