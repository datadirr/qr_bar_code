#include "include/qr_bar_code/qr_bar_code_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "qr_bar_code_plugin.h"

void QrBarCodePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  qr_bar_code::QrBarCodePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
