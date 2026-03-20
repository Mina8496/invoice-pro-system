abstract class Failure {
  final String message;

  Failure(this.message);
}

class DatabaseFailure extends Failure {
   // ignore: use_super_parameters
   DatabaseFailure(String message) : super(message);
}