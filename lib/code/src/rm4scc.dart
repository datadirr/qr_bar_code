import '../code_generate.dart';
import 'barcode_hm.dart';
import 'barcode_maps.dart';

/// RM4SCC Barcode
///
/// The RM4SCC is used for the Royal Mail CleanMail service. It enables UK
/// postcodes as well as Delivery Point Suffixes (DPSs) to be easily read by
/// a machine at high speed.
class BarcodeRm4scc extends BarcodeHM {
  /// Create an RM4SCC Barcode
  const BarcodeRm4scc();

  @override
  Iterable<int> get charSet => BarcodeMaps.rm4scc.keys;

  @override
  String get name => 'RM4SCC';

  @override
  Iterable<BarcodeHMBar> convertHM(String data) sync* {
    yield fromBits(BarcodeMaps.rm4sccStart);

    var sumTop = 0;
    var sumBottom = 0;
    final keys = BarcodeMaps.rm4scc.keys.toList();

    for (final codeUnit in data.codeUnits) {
      final code = BarcodeMaps.rm4scc[codeUnit];
      if (code == null) {
        throw BarcodeException(
            'Unable to encode "${String.fromCharCode(codeUnit)}" to $name');
      }
      yield* addHW(code, BarcodeMaps.rm4sccLen);

      final index = keys.indexOf(codeUnit);
      sumTop += (index ~/ 6 + 1) % 6;
      sumBottom += (index + 1) % 6;
    }

    final crc = ((sumTop - 1) % 6) * 6 + (sumBottom - 1) % 6;
    yield* addHW(BarcodeMaps.rm4scc[keys[crc]]!, BarcodeMaps.rm4sccLen);

    yield fromBits(BarcodeMaps.rm4sccStop);
  }
}
