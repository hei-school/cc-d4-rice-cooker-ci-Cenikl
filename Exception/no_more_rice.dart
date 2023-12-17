class NoMoreRice implements Exception {
  final String message;
  NoMoreRice(this.message);
  @override
  String toString() => 'CustomError: $message';
}