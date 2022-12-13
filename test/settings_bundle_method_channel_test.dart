import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings_bundle/settings_bundle_method_channel.dart';

void main() {
  MethodChannelSettingsBundle platform = MethodChannelSettingsBundle();
  const MethodChannel channel = MethodChannel('settings_bundle');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
