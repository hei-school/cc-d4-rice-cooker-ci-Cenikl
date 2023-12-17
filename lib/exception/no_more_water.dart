class NoMoreWater implements Exception {
  final String message;
  NoMoreWater(this.message);
  @override
  String toString() => 'CustomError: $message';
}