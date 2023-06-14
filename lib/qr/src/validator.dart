import 'error_correct_level.dart';
import 'input_too_long_exception.dart';
import 'qr_code.dart';
import 'qr_version.dart';

/// A utility class for validating and pre-rendering QR code data.
class QRValidator {
  /// Attempt to parse / generate the QR code data and check for any errors. The
  /// resulting [QRValidationResult] object will hold the status of the QR code
  /// as well as the generated QR code data.
  static QRValidationResult validate({
    required String data,
    int version = QRVersion.auto,
    int errorCorrectionLevel = QRErrorCorrectLevel.L,
  }) {
    late final QRCode qrCode;
    try {
      if (version != QRVersion.auto) {
        qrCode = QRCode(version, errorCorrectionLevel);
        qrCode.addData(data);
      } else {
        qrCode = QRCode.fromData(
          data: data,
          errorCorrectLevel: errorCorrectionLevel,
        );
      }
      return QRValidationResult(
        status: QRValidationStatus.valid,
        qrCode: qrCode,
      );
    } on InputTooLongException catch (title) {
      return QRValidationResult(
        status: QRValidationStatus.contentTooLong,
        error: title,
      );
    } on Exception catch (ex) {
      return QRValidationResult(status: QRValidationStatus.error, error: ex);
    }
  }
}

/// Captures the status or a QR code validation operations, as well as the
/// rendered and validated data / object so that it can be used in any
/// secondary operations (to avoid re-rendering). It also keeps any exception
/// that was thrown.
class QRValidationResult {
  /// Create a new validation result instance.
  QRValidationResult({required this.status, this.qrCode, this.error});

  /// The status of the validation operation.
  QRValidationStatus status;

  /// The rendered QR code data / object.
  QRCode? qrCode;

  /// The exception that was thrown in the event of a non-valid result (if any).
  Exception? error;

  /// The validation result returned a status of valid;
  bool get isValid => status == QRValidationStatus.valid;
}

/// The status of the QR code data you requested to be validated.
enum QRValidationStatus {
  /// The QR code data is valid for the provided parameters.
  valid,

  /// The QR code data is too long for the provided version + error check
  /// configuration or too long to be contained in a QR code.
  contentTooLong,

  /// An unknown / unexpected error occurred when we tried to validate the QR
  /// code data.
  error
}
