abstract class Failure {
  final String message;
  const Failure(this.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Unknown failure']);
}
