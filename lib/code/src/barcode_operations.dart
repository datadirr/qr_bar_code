/// [Barcode] drawing operation
class BarcodeElement {
  /// Create a [Barcode] drawing operation
  const BarcodeElement({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  /// left position of this element
  final double left;

  /// top position of this element
  final double top;

  /// width of this element
  final double width;

  /// height of this element
  final double height;

  /// right position of this element
  double get right => left + width;

  /// bottom position of this element
  double get bottom => top + height;

  @override
  String toString() => '$runtimeType $left $top $width $height';
}

/// Rectangle drawing operation
class BarcodeBar extends BarcodeElement {
  /// Create a rectangle drawing operation to draw a white or black unit
  const BarcodeBar({
    required double left,
    required double top,
    required double width,
    required double height,
    required this.black,
  }) : super(
          left: left,
          top: top,
          width: width,
          height: height,
        );

  /// Black or white color of this rectangle
  final bool black;

  @override
  String toString() =>
      '$runtimeType [${black ? 'X' : ' '}] $left $top $width $height';
}

/// Text alignment inside the [BarcodeText] zone
enum BarcodeTextAlign {
  /// Align on the middle left
  left,

  /// Align on the middle center
  center,

  /// Align on the middle right
  right
}

/// Text drawing operation
class BarcodeText extends BarcodeElement {
  /// Create a ext drawing operation
  const BarcodeText({
    required double left,
    required double top,
    required double width,
    required double height,
    required this.text,
    required this.align,
  }) : super(
          left: left,
          top: top,
          width: width,
          height: height,
        );

  /// Text to display in this rectangle
  final String text;

  /// Text alignment
  final BarcodeTextAlign align;

  @override
  String toString() => '$runtimeType "$text" $left $top $width $height $align';
}
