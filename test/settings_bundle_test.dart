import 'package:flutter_test/flutter_test.dart';
import 'package:settings_bundle/settings_bundle_platform_interface.dart';
import 'package:settings_bundle/settings_bundle_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSettingsBundlePlatform
    with MockPlatformInterfaceMixin
    implements SettingsBundlePlatform {
  @override
  Future<T> get<T>(String key) {
    return Future.value(null);
  }

  @override
  Future<bool?> set(String key, dynamic value) {
    throw UnimplementedError();
  }

  @override
  Stream<Map<String, dynamic>> get didChangeSettings =>
      throw UnimplementedError();
}

void main() {
  final SettingsBundlePlatform initialPlatform =
      SettingsBundlePlatform.instance;

  test('$MethodChannelSettingsBundle is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSettingsBundle>());
  });
}
