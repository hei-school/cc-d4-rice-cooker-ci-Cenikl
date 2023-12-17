class NotPluggedIn implements Exception {
  final String message;
  NotPluggedIn(this.message);
  @override
  String toString() => 'CustomError: $message';
}