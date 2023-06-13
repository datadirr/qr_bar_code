import 'package:flutter_test/flutter_test.dart';
import 'package:qr_bar_code/qr_bar_code.dart';
import 'package:qr_bar_code/qr_bar_code_platform_interface.dart';
import 'package:qr_bar_code/qr_bar_code_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockQrBarCodePlatform
    with MockPlatformInterfaceMixin
    implements QrBarCodePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final QrBarCodePlatform initialPlatform = QrBarCodePlatform.instance;

  test('$MethodChannelQrBarCode is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelQrBarCode>());
  });

  test('getPlatformVersion', () async {
    QrBarCode qrBarCodePlugin = QrBarCode();
    MockQrBarCodePlatform fakePlatform = MockQrBarCodePlatform();
    QrBarCodePlatform.instance = fakePlatform;

    expect(await qrBarCodePlugin.getPlatformVersion(), '42');
  });
}
