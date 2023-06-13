#ifndef FLUTTER_PLUGIN_QR_BAR_CODE_PLUGIN_H_
#define FLUTTER_PLUGIN_QR_BAR_CODE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace qr_bar_code {

class QrBarCodePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  QrBarCodePlugin();

  virtual ~QrBarCodePlugin();

  // Disallow copy and assign.
  QrBarCodePlugin(const QrBarCodePlugin&) = delete;
  QrBarCodePlugin& operator=(const QrBarCodePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace qr_bar_code

#endif  // FLUTTER_PLUGIN_QR_BAR_CODE_PLUGIN_H_
