import 'barcode_1d.dart';
import 'barcode_exception.dart';
import 'barcode_maps.dart';

/// Code 93 [Barcode]
///
/// Code 93 is a barcode symbology designed in 1982 by Intermec to provide
/// a higher density and data security enhancement to Code 39.
///
/// It is an alphanumeric, variable length symbology.
///
/// Code 93 is used primarily by Canada Post to encode supplementary
/// delivery information.
class BarcodeCode93 extends Barcode1D {
  /// Create a Code 93 Barcode
  const BarcodeCode93();

  @override
  Iterable<int> get charSet => BarcodeMaps.code93.keys.where((int x) => x > 0);

  @override
  String get name => 'CODE 93';

  @override
  Iterable<bool> convert(String data) sync* {
    // Start
    yield* add(BarcodeMaps.code93StartStop, BarcodeMaps.code93Len);

    final keys = BarcodeMaps.code93.keys.toList();

    for (var code in data.codeUnits) {
      final codeValue = BarcodeMaps.code93[code];
      if (codeValue == null) {
        throw BarcodeException(
            'Unable to encode "${String.fromCharCode(code)}" to $name Barcode');
      }
      yield* add(codeValue, BarcodeMaps.code93Len);
    }

    // Checksum
    var sumC = 0;
    var sumK = 0;
    var indexC = 1;
    var indexK = 2;

    for (var index = data.codeUnits.length - 1; index >= 0; index--) {
      final code = data.codeUnits[index];
      sumC += keys.indexOf(code) * indexC;
      sumK += keys.indexOf(code) * indexK;

      indexC++;
      if (indexC > 20) {
        indexC = 1;
      }
      indexK++;
      if (indexK > 15) {
        indexK = 1;
      }
    }

    sumC = sumC % 47;
    yield* add(BarcodeMaps.code93[keys[sumC]]!, BarcodeMaps.code93Len);

    sumK = (sumK + sumC) % 47;
    yield* add(BarcodeMaps.code93[keys[sumK]]!, BarcodeMaps.code93Len);

    // Stop
    yield* add(BarcodeMaps.code93StartStop, BarcodeMaps.code93Len);

    // Termination Bar
    yield true;
  }
}
