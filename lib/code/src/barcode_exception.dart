/// [Exception] raised if the library cannot generate the [Barcode]
class BarcodeException implements Exception {
  /// Create a [BarcodeException] object
  const BarcodeException(this.message);

  /// Error message
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}
