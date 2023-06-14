/// Supported barcode types
enum CodeType {
  /// ITF16 Barcode
  codeITF16,

  /// ITF14 Barcode
  codeITF14,

  /// EAN 13 barcode
  codeEAN13,

  /// EAN 8 barcode
  codeEAN8,

  /// EAN 5 barcode
  codeEAN5,

  /// EAN 2 barcode
  codeEAN2,

  /// ISBN barcode
  codeISBN,

  /// Code 39 barcode
  code39,

  /// Code 93 barcode
  code93,

  /// UPC-A barcode
  codeUPCA,

  /// UPC-E barcode
  codeUPCE,

  /// Code 128 barcode
  code128,

  /// GS1-128 barcode
  gs128,

  /// Telepen Barcode
  telepen,

  /// QR Code
  qrCode,

  /// Codabar
  codeBar,

  /// Pdf417
  pdf417,

  /// Datamatrix
  dataMatrix,

  /// Aztec
  aztec,

  /// RM4SCC
  rm4scc,

  /// Interleaved 2 of 5 (ITF)
  itf,
}
