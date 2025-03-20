import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'code_type.dart';
import 'painter.dart';

/// Error builder callback
typedef BarcodeErrorBuilder =
    Widget Function(BuildContext context, String error);

/// Flutter widget to draw a [CodeType] on screen.
class Code extends StatelessWidget {
  /// Draw a barcode on screen
  const Code({
    super.key,
    required String data,
    required this.codeType,
    this.color = Colors.black,
    this.backgroundColor,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.drawText = true,
    this.style,
    this.textPadding = 5,
    this.errorBuilder,
  }) : _dataBytes = null,
       _dataString = data;

  /// Draw a barcode on screen using Uint8List data
  const Code.fromBytes({
    super.key,
    required Uint8List data,
    required this.codeType,
    this.color = Colors.black,
    this.backgroundColor,
    this.decoration,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.drawText = true,
    this.style,
    this.textPadding = 5,
    this.errorBuilder,
  }) : _dataBytes = data,
       _dataString = null;

  /// The barcode data to display
  final Uint8List? _dataBytes;
  final String? _dataString;

  Uint8List get data => _dataBytes ?? utf8.encoder.convert(_dataString!);

  /// Is this raw bytes
  bool get isBytes => _dataBytes != null;

  /// The type of code to use.
  /// use:
  ///   * Code.code128()
  ///   * Code.ean13()
  ///   * ...
  final CodeType codeType;

  /// The bars color
  /// should be black or really dark color
  final Color color;

  /// The background color.
  /// this should be white or really light color
  final Color? backgroundColor;

  /// Padding to apply
  final EdgeInsetsGeometry? padding;

  /// Margin to apply
  final EdgeInsetsGeometry? margin;

  /// Width of the barcode with padding
  final double? width;

  /// Height of the barcode with padding
  final double? height;

  /// Whether to draw the text with the barcode
  final bool drawText;

  /// Text style to use to draw the text
  final TextStyle? style;

  /// Padding to add between the text and the barcode
  final double textPadding;

  /// Decoration to apply to the barcode
  final Decoration? decoration;

  /// Displays a custom widget in case of error with the barcode.
  final BarcodeErrorBuilder? errorBuilder;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    var effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }

    Widget child =
        isBytes
            ? BarcodePainter.fromBytes(
              _dataBytes,
              codeType,
              color,
              drawText,
              effectiveTextStyle,
              textPadding,
            )
            : BarcodePainter(
              _dataString,
              codeType,
              color,
              drawText,
              effectiveTextStyle,
              textPadding,
            );

    if (errorBuilder != null) {
      try {
        if (isBytes) {
          codeType.verifyBytes(_dataBytes!);
        } else {
          codeType.verify(_dataString!);
        }
      } catch (e) {
        child = errorBuilder!(context, e.toString());
      }
    }

    if (padding != null) {
      child = Padding(padding: padding!, child: child);
    }

    if (decoration != null) {
      child = DecoratedBox(decoration: decoration!, child: child);
    } else if (backgroundColor != null) {
      child = DecoratedBox(
        decoration: BoxDecoration(color: backgroundColor),
        child: child,
      );
    }

    if (width != null || height != null) {
      child = SizedBox(width: width, height: height, child: child);
    }

    if (margin != null) {
      child = Padding(padding: margin!, child: child);
    }

    return child;
  }
}
