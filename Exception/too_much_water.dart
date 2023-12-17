class TooMuchWater implements Exception {
  final String message;
  TooMuchWater(this.message);
  @override
  String toString() => 'CustomError: $message';
}
