class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;
  AppExceptions([this._message, this._prefix]);
  @override
  String toString() {
    return '$_message,$_prefix';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, 'Error while communicating with server');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class NotFoundException extends AppExceptions {
  NotFoundException([String? message]) : super(message, 'Resource not found');
}

class UnAuthorisedException extends AppExceptions {
  UnAuthorisedException([String? message])
      : super(message, 'You are not authorized for this action');
}

class ServerErrorException extends AppExceptions {
  ServerErrorException([String? message])
      : super(message, 'Server is experiencing technical difficulties');
}
