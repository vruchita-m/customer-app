class AppException implements Exception {
  final _message;
  final _prefix;
  AppException(this._message, this._prefix);
  @override
  String toString() {
    return '$_message$_prefix';
  }
}

class NoInternetException extends AppException {
  NoInternetException([String? message])
      : super(message, 'No Internet Connection');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, "You don't have access to this");
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message]) : super(message, "Request time out");
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}
