import 'barcode_exception.dart';
import 'barcode_maps.dart';
import 'ean2.dart';

/// EAN 5 Barcode
///
/// The EAN-5 is a 5-digit European Article Number code, and is a supplement
/// to the EAN-13 barcode used on books. It is used to give a suggestion
/// for the price of the book.
class BarcodeEan5 extends BarcodeEan2 {
  /// EAN 5 Barcode
  const BarcodeEan5();

  @override
  String get name => 'EAN 5';

  @override
  int get minLength => 5;

  @override
  int get maxLength => 5;

  @override
  String checkSumModulo10(String data) {
    var sum = 0;
    var fak = data.length;
    for (var c in data.codeUnits) {
      if (fak % 2 == 0) {
        sum += (c - 0x30) * 9;
      } else {
        sum += (c - 0x30) * 3;
      }
      fak--;
    }
    return String.fromCharCode((sum % 10) + 0x30);
  }

  @override
  Iterable<bool> convert(String data) sync* {
    verify(data);
    final checksum = checkSumModulo10(data);
    final pattern = BarcodeMaps.ean5Checksum[checksum.codeUnitAt(0)];

    // Start
    yield* add(BarcodeMaps.eanStartEan2, 5);

    var index = 0;
    for (var code in data.codeUnits) {
      final codes = BarcodeMaps.ean[code];

      if (codes == null) {
        throw BarcodeException(
          'Unable to encode "${String.fromCharCode(code)}" to $name Barcode',
        );
      }

      if (index >= 1) {
        yield* add(BarcodeMaps.eanCenterEan2, 2);
      }

      yield* add(codes[(pattern! >> index) & 1], 7);
      index++;
    }
  }
}
