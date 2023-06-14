import 'package:flutter/widgets.dart';
import 'qr_version.dart';

/// An exception that is thrown when an invalid QR code version / type is
/// requested.
class QRUnsupportedVersionException implements Exception {
  /// Create a new QrUnsupportedVersionException.
  factory QRUnsupportedVersionException(int providedVersion) {
    final message =
        'Invalid version. $providedVersion is not >= ${QRVersion.min} '
        'and <= ${QRVersion.max}';
    return QRUnsupportedVersionException._internal(providedVersion, message);
  }

  QRUnsupportedVersionException._internal(this.providedVersion, this.message);

  /// The version you passed to the QR code operation.
  final int providedVersion;

  /// A message describing the exception state.
  final String message;

  @override
  String toString() => 'QRUnsupportedVersionException: $message';
}

/// An exception that is thrown when something goes wrong with the
/// [ImageProvider] for the embedded image of a QrImageView or QrPainter.
class QREmbeddedImageException implements Exception {
  /// Create a new QrEmbeddedImageException.
  factory QREmbeddedImageException(String message) {
    return QREmbeddedImageException._internal(message);
  }
  QREmbeddedImageException._internal(this.message);

  /// A message describing the exception state.
  final String message;

  @override
  String toString() => 'QREmbeddedImageException: $message';
}
