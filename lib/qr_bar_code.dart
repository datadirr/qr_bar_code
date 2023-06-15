import 'qr_bar_code_platform_interface.dart';

class QrBarCode {
  Future<String?> getPlatformVersion() {
    return QrBarCodePlatform.instance.getPlatformVersion();
  }
}
