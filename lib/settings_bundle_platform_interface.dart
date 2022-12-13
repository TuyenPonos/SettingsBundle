import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'settings_bundle_method_channel.dart';

abstract class SettingsBundlePlatform extends PlatformInterface {
  /// Constructs a SettingsBundlePlatform.
  SettingsBundlePlatform() : super(token: _token);

  static final Object _token = Object();

  static SettingsBundlePlatform _instance = MethodChannelSettingsBundle();

  /// The default instance of [SettingsBundlePlatform] to use.
  ///
  /// Defaults to [MethodChannelSettingsBundle].
  static SettingsBundlePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SettingsBundlePlatform] when
  /// they register themselves.
  static set instance(SettingsBundlePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Using to get settings value by [key]
  /// [T] is type of value base on element types
  /// return [T] or null
  Future<T?> get<T>(String key) {
    return instance.get(key);
  }

  /// Using to update settings value by [key] and [value]
  Future<bool?> set(String key, dynamic value) {
    return instance.set(key, value);
  }

  /// Listen did change settings value as Stream data
  Stream<Map<String, dynamic>> get didChangeSettings {
    return instance.didChangeSettings;
  }
}
