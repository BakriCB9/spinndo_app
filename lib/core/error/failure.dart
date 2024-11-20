abstract class Failure {
  final String message;

  Failure(this.message);
}

class RemotFailure extends Failure {
  RemotFailure(super.message);
}

class LocalFailure extends Failure {
  LocalFailure(super.message);
}
class GoogleMapFailure extends Failure {
  GoogleMapFailure(super.message);
}
