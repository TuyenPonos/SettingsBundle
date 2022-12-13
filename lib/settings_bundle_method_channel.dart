import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'settings_bundle_platform_interface.dart';

/// An implementation of [SettingsBundlePlatform] that uses method channels.
class MethodChannelSettingsBundle extends SettingsBundlePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('settings_bundle');

  @visibleForTesting
  final eventChannel = const EventChannel('did_change_settings_bundle');

  @override
  Future<T?> get<T>(String key) async {
    try {
      final response = await methodChannel
          .invokeMethod<T>('getSettingsBundle', {'key': key});
      return response;
    } on PlatformException catch (e) {
      if (e.code == "-404") {
        throw Exception("Key $key is not registered in Setting.bundle");
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<bool?> set(
    String key,
    dynamic value,
  ) async {
    final response = await methodChannel.invokeMethod<bool>(
      'setSettingsBundle',
      {
        'key': key,
        'value': value,
      },
    );
    return response;
  }

  @override
  Stream<Map<String, dynamic>> get didChangeSettings {
    return eventChannel.receiveBroadcastStream().cast().map((event) {
      return Map.from(event);
    });
  }
}
