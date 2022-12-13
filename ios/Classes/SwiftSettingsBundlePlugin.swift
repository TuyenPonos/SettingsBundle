import Flutter
import UIKit

public class SwiftSettingsBundlePlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    var eventSink: FlutterEventSink?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "settings_bundle", binaryMessenger: registrar.messenger())
        let instance = SwiftSettingsBundlePlugin()
        let didChangeSettings = FlutterEventChannel(name: "did_change_settings_bundle", binaryMessenger: registrar.messenger())
        didChangeSettings.setStreamHandler(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }

    public func applicationDidBecomeActive(_ application: UIApplication) {
        registerDefaultsFromSettingsBundle()
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        NotificationCenter.default.addObserver(self, selector: #selector(updateDisplayFromDefaults), name: UserDefaults.didChangeNotification, object: nil)
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    func registerDefaultsFromSettingsBundle() {
        let settingsName = "Settings"
        let settingsExtension = "bundle"
        let settingsRootPlist = "Root.plist"
        let settingsPreferencesItems = "PreferenceSpecifiers"
        let settingsPreferenceKey = "Key"
        let settingsPreferenceDefaultValue = "DefaultValue"
        guard let settingsBundleURL = Bundle.main.url(forResource: settingsName, withExtension: settingsExtension),
              let settingsData = try? Data(contentsOf: settingsBundleURL.appendingPathComponent(settingsRootPlist)),
              let settingsPlist = try? PropertyListSerialization.propertyList(
                  from: settingsData,
                  options: [],
                  format: nil) as? [String: Any],
              let settingsPreferences = settingsPlist[settingsPreferencesItems] as? [[String: Any]] else {
            return
        }

        var defaultsToRegister = [String: Any]()

        settingsPreferences.forEach { preference in
            if let key = preference[settingsPreferenceKey] as? String {
                defaultsToRegister[key] = preference[settingsPreferenceDefaultValue]
            }
        }

        UserDefaults.standard.register(defaults: defaultsToRegister)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getSettingsBundle" {
            if let args = call.arguments as? Dictionary<String, String>,
               let _key = args["key"] {
                if let data = UserDefaults.standard.value(forKey: _key) {
                    result(data)
                } else {
                    result(FlutterError(code: "-404", message: "Not found", details: nil))
                }
            }
        } else if call.method == "setSettingsBundle" {
            if let args = call.arguments as? Dictionary<String, Any>,
               let _key = args["key"] as? String?, let _value = args["value"] {
                if _key == nil {
                    result(false)
                } else {
                    UserDefaults.standard.set(_value, forKey: _key!)
                    result(true)
                }
            } else {
                result(false)
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    @objc private func updateDisplayFromDefaults() {
        guard let eventSink = eventSink else { return }
        eventSink(UserDefaults.standard.dictionaryRepresentation())
    }
}
