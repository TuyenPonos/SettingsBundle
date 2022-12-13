import 'settings_bundle_platform_interface.dart';

class SettingsBundle {
  /// Using to get settings value by [key]
  /// [T] is type of value base on element types
  /// return [T] or null
  Future<T?> get<T>(String key) {
    return SettingsBundlePlatform.instance.get(key);
  }

  /// Using to update settings value by [key] and [value]
  Future<bool?> set(String key, dynamic value) {
    return SettingsBundlePlatform.instance.set(key, value);
  }

  /// Listen did change settings value as Stream data
  Stream<Map<String, dynamic>> get didChangeSettings {
    return SettingsBundlePlatform.instance.didChangeSettings;
  }
}
