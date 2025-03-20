import 'barcode_exception.dart';
import 'barcode_maps.dart';
import 'barcode_operations.dart';
import 'ean.dart';

/// EAN 2 Barcode
///
/// The EAN-2 is a supplement to the EAN-13 and UPC-A barcodes.
/// It is often used on magazines and periodicals to indicate an issue number.
class BarcodeEan2 extends BarcodeEan {
  /// EAN 2 Barcode
  const BarcodeEan2();

  @override
  String get name => 'EAN 2';

  @override
  int get minLength => 2;

  @override
  int get maxLength => 2;

  @override
  Iterable<bool> convert(String data) sync* {
    verify(data);
    int iData;
    try {
      iData = int.parse(data);
    } catch (e) {
      throw BarcodeException('Unable to encode "$data" to $name Barcode');
    }
    final pattern = iData % 4;

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

      if (index == 1) {
        yield* add(BarcodeMaps.eanCenterEan2, 2);
      }

      yield* add(codes[((pattern >> index) & 1) ^ 1], 7);
      index++;
    }
  }

  @override
  double marginTop(
    bool drawText,
    double width,
    double height,
    double fontHeight,
    double textPadding,
  ) => drawText ? fontHeight + textPadding : 0;

  @override
  double getHeight(
    int index,
    int count,
    double width,
    double height,
    double fontHeight,
    double textPadding,
    bool drawText,
  ) => height;

  @override
  Iterable<BarcodeElement> makeText(
    String data,
    double width,
    double height,
    double fontHeight,
    double textPadding,
    double lineWidth,
  ) sync* {
    yield BarcodeText(
      left: 0,
      top: 0,
      width: width,
      height: fontHeight,
      text: data,
      align: BarcodeTextAlign.center,
    );
  }

  @override
  String normalize(String data) =>
      data.padRight(minLength, '0').substring(0, minLength);
}
