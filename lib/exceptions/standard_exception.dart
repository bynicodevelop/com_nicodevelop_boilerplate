class StandardException implements Exception {
  final String message;
  final String code;

  StandardException(
    this.message,
    this.code,
  );
}
