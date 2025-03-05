// ignore_for_file: annotate_overrides, overridden_fields

abstract class Failure {
  const Failure(this.title, this.message);
  final String title;
  final String message;

  List<Object> get props => [title, message];
}

class ServerFailure extends Failure {
  const ServerFailure(this.title, this.message) : super(title, message);
  final String title;
  final String message;
}

class CommonFailure extends Failure {
  const CommonFailure(super.title, super.message);
}

class InternetFailure extends Failure {
  const InternetFailure(super.title, super.message);
}
