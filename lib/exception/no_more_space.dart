class NoMoreSpace implements Exception {
  final String message;
  NoMoreSpace(this.message);
  @override
  String toString() => 'CustomError: $message';
}