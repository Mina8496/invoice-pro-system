abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  // ignore: use_super_parameters
  ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  // ignore: use_super_parameters
  CacheFailure(String message) : super(message);
}

class NetWorkFailure extends Failure {
  // ignore: use_super_parameters
  NetWorkFailure(String message) : super(message);
}
