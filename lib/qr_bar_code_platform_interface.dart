import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'qr_bar_code_method_channel.dart';

abstract class QrBarCodePlatform extends PlatformInterface {
  /// Constructs a QrBarCodePlatform.
  QrBarCodePlatform() : super(token: _token);

  static final Object _token = Object();

  static QrBarCodePlatform _instance = MethodChannelQrBarCode();

  /// The default instance of [QrBarCodePlatform] to use.
  ///
  /// Defaults to [MethodChannelQrBarCode].
  static QrBarCodePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [QrBarCodePlatform] when
  /// they register themselves.
  static set instance(QrBarCodePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
