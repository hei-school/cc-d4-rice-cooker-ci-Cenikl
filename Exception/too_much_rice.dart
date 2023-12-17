class TooMuchRice implements Exception {
  final String message;
  TooMuchRice(this.message);
  @override
  String toString() => 'CustomError: $message';
}