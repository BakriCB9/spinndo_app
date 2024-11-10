abstract class AppException implements Exception {
  final String message;

  AppException([this.message = 'Something went wrong!']);
}

class RemoteAppException extends AppException {
  RemoteAppException([super.message]);
}

class LocalAppException extends AppException {
  LocalAppException([super.message]);
}
