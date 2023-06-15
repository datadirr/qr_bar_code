import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'code_type.dart';
import 'barcode_exception.dart';
import 'barcode_operations.dart';

/// Barcode renderer
class BarcodePainter extends LeafRenderObjectWidget {
  /// Create a Barcode renderer
  const BarcodePainter(
    this._dataString,
    this.barcode,
    this.color,
    this.drawText,
    this.style,
    this.textPadding, {
    Key? key,
  })  : _dataBytes = null,
        super(key: key);

  const BarcodePainter.fromBytes(
    this._dataBytes,
    this.barcode,
    this.color,
    this.drawText,
    this.style,
    this.textPadding, {
    Key? key,
  })  : _dataString = null,
        super(key: key);

  /// The Data to include in the barcode
  final Uint8List? _dataBytes;
  final String? _dataString;

  Uint8List get data => _dataBytes ?? utf8.encoder.convert(_dataString!);

  /// Is this raw bytes
  bool get isBytes => _dataBytes != null;

  /// The barcode rendering object
  final CodeType barcode;

  /// The color of the barcode elements, usually black
  final Color color;

  /// Draw the text if any
  final bool drawText;

  /// Text style to use
  final TextStyle? style;

  /// Padding to add between the text and the barcode
  final double textPadding;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderBarcode(
      _dataBytes,
      _dataString,
      barcode,
      Paint()..color = color,
      drawText,
      style,
      textPadding,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderBarcode renderObject) {
    if (renderObject.dataBytes != _dataBytes ||
        renderObject.dataString != _dataString ||
        renderObject.barcode != barcode ||
        renderObject.barStyle.color != color ||
        renderObject.drawText != drawText ||
        renderObject.style != style ||
        renderObject.textPadding != textPadding) {
      renderObject
        ..dataBytes = _dataBytes
        ..dataString = _dataString
        ..barcode = barcode
        ..barStyle = (Paint()
          ..color = color
          ..isAntiAlias = false)
        ..drawText = drawText
        ..style = style
        ..textPadding = textPadding;
      renderObject.markNeedsPaint();
    }
  }
}

class RenderBarcode extends RenderBox {
  RenderBarcode(
    this.dataBytes,
    this.dataString,
    this.barcode,
    this.barStyle,
    this.drawText,
    this.style,
    this.textPadding,
  );

  Uint8List? dataBytes;

  String? dataString;

  /// Is this raw bytes
  bool get isBytes => dataBytes != null;

  CodeType barcode;

  Paint barStyle;

  bool drawText;

  TextStyle? style;

  double textPadding;

  @override
  bool get sizedByParent => true;

  Size _computeSize(BoxConstraints constraints) {
    var size = constraints.biggest;

    if (size.width >= double.infinity) {
      if (size.height >= double.infinity) {
        size = const Size(200, 100);
      } else {
        size = Size(size.height * 2, size.height);
      }
    }
    if (size.height >= double.infinity) {
      size = Size(size.width, size.width / 2);
    }
    return size;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(constraints);
  }

  @override
  void performResize() {
    size = _computeSize(constraints);
  }

  void paintBar(PaintingContext context, Offset offset, BarcodeBar element) {
    if (!element.black) {
      return;
    }

    context.canvas.drawRect(
      Rect.fromLTWH(
        offset.dx + element.left,
        offset.dy + element.top,
        element.width,
        element.height,
      ),
      barStyle,
    );
  }

  void paintText(PaintingContext context, Offset offset, BarcodeText element) {
    TextAlign? align;
    switch (element.align) {
      case BarcodeTextAlign.left:
        align = TextAlign.left;
        break;
      case BarcodeTextAlign.center:
        align = TextAlign.center;
        break;
      case BarcodeTextAlign.right:
        align = TextAlign.right;
        break;
    }

    final builder = ui.ParagraphBuilder(
      style!.getParagraphStyle(
          textAlign: align,
          fontSize: element.height,
          maxLines: 1,
          ellipsis: '...'),
    )
      ..pushStyle(style!.getTextStyle())
      ..addText(element.text);

    final paragraph = builder.build();
    paragraph.layout(ui.ParagraphConstraints(width: element.width));

    context.canvas.drawParagraph(
      paragraph,
      Offset(
          offset.dx + element.left,
          offset.dy +
              element.top +
              paragraph.alphabeticBaseline -
              paragraph.height),
    );
  }

  void drawError(PaintingContext context, ui.Offset offset, String message) {
    final errorBox = RenderErrorBox(message);
    errorBox.layout(constraints);
    errorBox.paint(context, offset);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    try {
      final recipe = isBytes
          ? barcode.makeBytes(
              dataBytes!,
              width: size.width,
              height: size.height,
              drawText: drawText,
              fontHeight: style!.fontSize,
              textPadding: textPadding,
            )
          : barcode.make(
              dataString!,
              width: size.width,
              height: size.height,
              drawText: drawText,
              fontHeight: style!.fontSize,
              textPadding: textPadding,
            );
      for (var element in recipe) {
        if (element is BarcodeBar) {
          paintBar(context, offset, element);
        } else if (element is BarcodeText) {
          paintText(context, offset, element);
        }
      }
    } on BarcodeException catch (error) {
      FlutterError.reportError(FlutterErrorDetails(
        exception: error,
        library: 'Barcode Widget',
      ));

      assert(() {
        drawError(context, offset, error.message);
        return true;
      }());
    }
  }

  @override
  bool hitTestSelf(Offset position) => true;
}
