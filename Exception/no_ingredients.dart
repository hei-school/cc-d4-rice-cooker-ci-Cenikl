class NoIngredients implements Exception {
  final String message;
  NoIngredients(this.message);
  @override
  String toString() => 'CustomError: $message';
}