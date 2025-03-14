//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <local_notifier/local_notifier_plugin.h>
#include <windows_notification/windows_notification_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  LocalNotifierPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("LocalNotifierPlugin"));
  WindowsNotificationPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowsNotificationPluginCApi"));
}
