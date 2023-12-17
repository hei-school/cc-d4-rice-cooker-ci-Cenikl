class NotMoreSpace implements Exception {
  final String message;
  NotMoreSpace(this.message);
  @override
  String toString() => 'CustomError: $message';
}