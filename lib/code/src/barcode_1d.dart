import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'code_type.dart';
import 'barcode_operations.dart';

/// One Dimension Barcode generation class
abstract class Barcode1D extends CodeType {
  /// Create a [Barcode1D] object
  const Barcode1D();

  /// Default padding between text and barcode
  static const defaultTextPadding = 0.0;

  @override
  Iterable<BarcodeElement> makeBytes(
    Uint8List data, {
    required double width,
    required double height,
    bool drawText = false,
    double? fontHeight,
    double? textPadding,
  }) sync* {
    assert(width > 0);
    assert(height > 0);
    assert(!drawText || fontHeight != null);
    fontHeight ??= 0;
    textPadding ??= defaultTextPadding;

    final text = utf8.decoder.convert(data);
    final bits = convert(text).toList();

    if (bits.isEmpty) {
      return;
    }

    final top = marginTop(drawText, width, height, fontHeight, textPadding);
    final left = marginLeft(drawText, width, height, fontHeight, textPadding);
    final right = marginRight(drawText, width, height, fontHeight, textPadding);
    final lineWidth = (width - left - right) / bits.length;

    var color = bits.first;
    var count = 1;

    for (var i = 1; i < bits.length; i++) {
      if (color == bits[i]) {
        count++;
        continue;
      }

      yield BarcodeBar(
        left: left + (i - count) * lineWidth,
        top: top,
        width: count * lineWidth,
        height: getHeight(
          i - count,
          count,
          width,
          height - top,
          fontHeight,
          textPadding,
          drawText,
        ),
        black: color,
      );

      color = bits[i];
      count = 1;
    }

    final l = bits.length;
    yield BarcodeBar(
      left: left + (l - count) * lineWidth,
      top: top,
      width: count * lineWidth,
      height: getHeight(
        l - count,
        count,
        width,
        height - top,
        fontHeight,
        textPadding,
        drawText,
      ),
      black: color,
    );

    if (drawText) {
      yield* makeText(text, width, height, fontHeight, textPadding, lineWidth);
    }
  }

  /// Get the bar height for a specific index
  @protected
  double getHeight(
    int index,
    int count,
    double width,
    double height,
    double fontHeight,
    double textPadding,
    bool drawText,
  ) {
    return height - (drawText ? fontHeight + textPadding : 0);
  }

  /// Margin at the top of the barcode
  @protected
  double marginTop(
    bool drawText,
    double width,
    double height,
    double fontHeight,
    double textPadding,
  ) => 0;

  /// Margin before the first bar
  @protected
  double marginLeft(
    bool drawText,
    double width,
    double height,
    double fontHeight,
    double textPadding,
  ) => 0;

  /// Margin after the last bar
  @protected
  double marginRight(
    bool drawText,
    double width,
    double height,
    double fontHeight,
    double textPadding,
  ) => 0;

  /// Stream the text operations required to draw the
  /// barcode texts. This is automatically called by [make]
  @protected
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
      top: height - fontHeight,
      width: width,
      height: fontHeight,
      text: data,
      align: BarcodeTextAlign.center,
    );
  }

  /// Build a stream of [bool] that represents a white or black bar
  /// from a bit encoded [int] with count as the number of bars to draw
  @protected
  Iterable<bool> add(int data, int count) sync* {
    for (var i = 0; i < count; i++) {
      yield (1 & (data >> i)) == 1;
    }
  }

  /// Computes a hexadecimal representation of the barcode, mostly for
  /// testing purposes
  @visibleForTesting
  String toHex(String data) {
    var intermediate = '';
    for (var bit in convert(data)) {
      intermediate += bit ? '1' : '0';
    }

    var result = '';
    while (intermediate.length > 8) {
      final sub = intermediate.substring(intermediate.length - 8);
      result += int.parse(sub, radix: 2).toRadixString(16);
      intermediate = intermediate.substring(0, intermediate.length - 8);
    }
    result += int.parse(intermediate, radix: 2).toRadixString(16);

    return result;
  }

  /// Get the generated texts, for testing purposes
  @visibleForTesting
  String getText(String data) {
    final result = StringBuffer();

    for (final elem in makeText(data, 200, 200, 10, 5, 10)) {
      if (elem is BarcodeText) {
        result.write(elem.text);
      }
    }

    return result.toString();
  }

  /// Actual barcode computation method, returns a stream of [bool]
  /// which represents the presence or absence of a bar
  @protected
  Iterable<bool> convert(String data);
}
