class NotEnoughWater implements Exception {
  final String message;
  NotEnoughWater(this.message);
  @override
  String toString() => 'CustomError: $message';
}