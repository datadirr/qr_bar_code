import 'barcode_operations.dart';
import 'ean13.dart';

/// ISBN Barcode
///
/// The International Standard Book Number is a numeric commercial book
/// identifier which is intended to be unique. Publishers purchase ISBNs
/// from an affiliate of the International ISBN Agency.
class BarcodeIsbn extends BarcodeEan13 {
  /// Create an ISBN Barcode
  const BarcodeIsbn(super.drawEndChar, this.drawIsbn);

  /// Draw the ISBN number as text on the top of the barcode
  final bool drawIsbn;

  @override
  double marginTop(
    bool drawText,
    double width,
    double height,
    double fontHeight,
    double textPadding,
  ) {
    if (!drawText || !drawIsbn) {
      return super.marginTop(drawText, width, height, fontHeight, textPadding);
    }

    return fontHeight + textPadding;
  }

  @override
  Iterable<BarcodeElement> makeText(
    String data,
    double width,
    double height,
    double fontHeight,
    double textPadding,
    double lineWidth,
  ) sync* {
    data = checkLength(data, maxLength);
    yield* super.makeText(
      data,
      width,
      height,
      fontHeight,
      textPadding,
      lineWidth,
    );

    if (drawIsbn) {
      final isbn =
          '${data.substring(0, 3)}-${data.substring(3, 12)}-${data.substring(12, 13)}';

      yield BarcodeText(
        left: 0,
        top: 0,
        width: width,
        height: fontHeight,
        text: 'ISBN $isbn',
        align: BarcodeTextAlign.center,
      );
    }
  }

  @override
  String get name => 'ISBN';
}
