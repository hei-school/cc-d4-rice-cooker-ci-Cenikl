class LidIsOpen implements Exception {
  final String message;
  LidIsOpen(this.message);
  @override
  String toString() => 'CustomError: $message';
}