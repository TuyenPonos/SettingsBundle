Preferences for iOS apps are displayed by the system-provided Settings app.

## Features

A settings bundle contains the information needed by these system apps to display your preferences and make it possible for the user to modify them. The system apps save the corresponding values to the defaults database so that your app can retrieve them at runtime. The plugin provides a simple API to retrieve them from Flutter:

- Get/set settings bundle values
- Listen settings bundle values change

The plugin support iOS only

![/example/demo.gif](https://github.com/TuyenPonos/SettingsBundle/blob/main/example/demo.gif)

## Settings Bundle

### 1. Element types

Settings Bundle support some element types

|Element Type           |Description                                                                   |
|:----------------------|:-----------------------------------------------------------------------------|
|`PSTextFieldSpecifier`  | A text field preference. This element displays an optional title and an editable text field. You can use this type for preferences that require the user to specify a custom string value.|
|`PSTitleValueSpecifier` | A read-only string preference. You can use this type to display preference values as formatted strings.|
|`PSToggleSwitchSpecifier` | A toggle switch preference. You can use this type to configure a preference that can have only one of two values. Although you typically use this type to represent preferences containing Boolean values, you can also use it with preferences containing non-Boolean values.|
|`PSSliderSpecifier` | A slider preference. You can use this type for a preference that represents a range of values. The value for this type is a real number whose minimum and maximum you specify.|
|`PSMultiValueSpecifier` | A multi-value preference. You can use this type for a preference that supports a set of mutually exclusive values.|
|`PSRadioGroupSpecifier` | A group item preference used for selecting one item in the group. This type represents a single configurable option with two or more values.|
|`PSGroupSpecifier`|A group item preference. The group type is a way for you to organize groups of preferences on a single page. The group type does not represent a configurable preference.|
|`PSChildPaneSpecifier`|A child pane preference. You can use this type to link to a new page of preferences.|

For more information, see [Settings Application Schema Reference](https://developer.apple.com/library/archive/documentation/PreferenceSettings/Conceptual/SettingsApplicationSchemaReference/Articles/RootContent.html#//apple_ref/doc/uid/TP40007018-SW1)


### 2. Adding a Settings bundle to your Xcode project:

1. Choose File > New > New File.
2. Under iOS, choose Resource, and then select the Settings Bundle template.
3. Name the file Settings.bundle.

For more information, see [Creating and Modifying the Settings Bundle](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/Preferences/Preferences.html#//apple_ref/doc/uid/10000059i-CH6-SW6)


## Get/Set settings bundle value

In your library add the following import:

```dart
import 'package:settings_bundle/settings_bundle.dart';
```

### 1. Get value

Using `get` function by passing the key name. The function can return the value or null

```dart
final bool? isDarkMode = await SettingsBundle().get<bool>('theme_mode');
```

### 2. Set value

Using `set` function by passing the key name and value.

```dart
await SettingsBundle().set('theme_mode', true);
```

### 3. Listen did change settings bundle values

You can listen latest settings values when have any changes as a Stream data

```dart
  late final StreamSubscription _changeSettingSubscription;

  @override
  void initState() {
    super.initState();
    _changeSettingSubscription =
        _settingsBundlePlugin.didChangeSettings.listen((values) {
     // handle values changed here
     // Type of values is Map<String, dynamic>
     print(values['theme_mode']);
    });
  }

  @override
  void dispose() {
    _changeSettingSubscription.cancel();
    super.dispose();
  }
```


## Example

Follow the [example](https://github.com/TuyenPonos/SettingsBundle/tree/main/example)

## Contributions 

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an issue.
If you fixed a bug or implemented a feature, please send a pull request.