#import "SettingsBundlePlugin.h"
#if __has_include(<settings_bundle/settings_bundle-Swift.h>)
#import <settings_bundle/settings_bundle-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "settings_bundle-Swift.h"
#endif

@implementation SettingsBundlePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSettingsBundlePlugin registerWithRegistrar:registrar];
}
@end
