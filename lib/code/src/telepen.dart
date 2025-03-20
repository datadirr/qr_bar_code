import 'barcode_1d.dart';
import 'barcode_exception.dart';
import 'barcode_maps.dart';

/// Telepen Barcode
///
/// Telepen is a barcode designed in 1972 in the UK to express all 128 ASCII
/// characters without using shift characters for code switching, and using
/// only two different widths for bars and spaces.
class BarcodeTelepen extends Barcode1D {
  /// Create a Telepen Barcode
  const BarcodeTelepen();

  @override
  Iterable<int> get charSet => Iterable<int>.generate(128);

  @override
  String get name => 'Telepen';

  @override
  Iterable<bool> convert(String data) sync* {
    // Start
    yield* add(BarcodeMaps.telepenStart, BarcodeMaps.telepenLen);

    var checksum = 0;

    for (var code in data.codeUnits) {
      if (code >= BarcodeMaps.telepen.length) {
        throw BarcodeException(
          'Unable to encode "${String.fromCharCode(code)}" to $name Barcode',
        );
      }
      final codeValue = BarcodeMaps.telepen[code];
      yield* add(codeValue, BarcodeMaps.telepenLen);
      checksum += code;
    }

    // Checksum
    checksum = 127 - (checksum % 127);
    if (checksum == 127) {
      checksum = 0;
    }
    yield* add(BarcodeMaps.telepen[checksum], BarcodeMaps.telepenLen);

    // Stop
    yield* add(BarcodeMaps.telepenEnd, BarcodeMaps.telepenLen);
  }
}
