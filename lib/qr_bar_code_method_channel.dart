import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'qr_bar_code_platform_interface.dart';

/// An implementation of [QrBarCodePlatform] that uses method channels.
class MethodChannelQrBarCode extends QrBarCodePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('qr_bar_code');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
