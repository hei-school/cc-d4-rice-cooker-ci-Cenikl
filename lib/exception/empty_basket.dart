class EmptyBasket implements Exception {
  final String message;
  EmptyBasket(this.message);
  @override
  String toString() => 'CustomError: $message';
}