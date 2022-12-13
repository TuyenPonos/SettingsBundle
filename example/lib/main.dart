import 'package:flutter/material.dart';
import 'dart:async';

import 'package:settings_bundle/settings_bundle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _settingsBundlePlugin = SettingsBundle();
  bool _isDarkMode = false;
  String _userName = '';
  String? _experienceLevel;
  bool _isAllowTracking = false;
  String? _timeTracking;
  double _gravity = 0.5;
  late final StreamSubscription _changeSettingSubscription;

  @override
  void initState() {
    super.initState();
    _changeSettingSubscription =
        _settingsBundlePlugin.didChangeSettings.listen((values) {
      if (mounted) {
        setState(() {
          _isDarkMode = values['theme_mode'];
          _userName = values['user_name'];
          _experienceLevel = values['experience_level'];
          _isAllowTracking = values['allow_tracking'];
          _timeTracking = values['tracking_type'];
          _gravity = values['slider_preference'];
        });
      }
    });
    initSettings();
  }

  @override
  void dispose() {
    _changeSettingSubscription.cancel();
    super.dispose();
  }

  Future<void> initSettings() async {
    final isDarkMode =
        await _settingsBundlePlugin.get<bool>('theme_mode') ?? false;
    final userName = await _settingsBundlePlugin.get<String>('user_name') ?? '';
    final exp = await _settingsBundlePlugin.get<String>('experience_level');
    final allowTracking =
        await _settingsBundlePlugin.get<bool>('allow_tracking') ?? false;
    final gravity =
        await _settingsBundlePlugin.get<double>('slider_preference') ?? 0.5;
    final timeTracking =
        await _settingsBundlePlugin.get<String>('tracking_type');
    if (!mounted) return;
    setState(() {
      _isDarkMode = isDarkMode;
      _userName = userName;
      _experienceLevel = exp;
      _isAllowTracking = allowTracking;
      _gravity = gravity;
      _timeTracking = timeTracking;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: _isDarkMode ? Colors.white : Colors.black,
    );
    final valueStyle = TextStyle(
      color: _isDarkMode ? Colors.white : Colors.black,
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        backgroundColor:
            _isDarkMode ? const Color.fromARGB(95, 56, 46, 46) : Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Dark Mode',
                      style: labelStyle,
                    ),
                  ),
                  Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      _settingsBundlePlugin.set('theme_mode', !_isDarkMode);
                    },
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'User Name',
                      style: labelStyle,
                    ),
                  ),
                  Text(
                    _userName,
                    style: valueStyle,
                  )
                ],
              ),
              const SizedBox(height: 15),
              Text(
                'Experience Level',
                style: labelStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<String?>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue;
                            }
                            return _isDarkMode ? Colors.white : Colors.grey;
                          }),
                          value: _experienceLevel,
                          groupValue: 'fresher',
                          onChanged: (value) {
                            _settingsBundlePlugin.set(
                                'experience_level', 'fresher');
                          },
                        ),
                        Text(
                          'Fresher',
                          style: valueStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String?>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue;
                            }
                            return _isDarkMode ? Colors.white : Colors.grey;
                          }),
                          value: _experienceLevel,
                          groupValue: 'junior',
                          onChanged: (value) {
                            _settingsBundlePlugin.set(
                              'experience_level',
                              'junior',
                            );
                          },
                        ),
                        Text(
                          'Junior',
                          style: valueStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String?>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue;
                            }
                            return _isDarkMode ? Colors.white : Colors.grey;
                          }),
                          value: _experienceLevel,
                          groupValue: 'middle',
                          onChanged: (value) {
                            _settingsBundlePlugin.set(
                              'experience_level',
                              'middle',
                            );
                          },
                        ),
                        Text(
                          'Middle',
                          style: valueStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String?>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue;
                            }
                            return _isDarkMode ? Colors.white : Colors.grey;
                          }),
                          value: _experienceLevel,
                          groupValue: 'senior',
                          onChanged: (value) {
                            _settingsBundlePlugin.set(
                              'experience_level',
                              'senior',
                            );
                          },
                        ),
                        Text(
                          'Senior',
                          style: valueStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Allow Tracking',
                      style: labelStyle,
                    ),
                  ),
                  Switch(
                    value: _isAllowTracking,
                    onChanged: (value) {
                      _settingsBundlePlugin.set(
                        'allow_tracking',
                        !_isAllowTracking,
                      );
                    },
                  )
                ],
              ),
              Text(
                'Time of tracking',
                style: labelStyle,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<String?>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue;
                            }
                            return _isDarkMode ? Colors.white : Colors.grey;
                          }),
                          value: _timeTracking,
                          groupValue: '0',
                          onChanged: (value) {
                            _settingsBundlePlugin.set('tracking_type', '0');
                          },
                        ),
                        Text(
                          'Always',
                          style: valueStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String?>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue;
                            }
                            return _isDarkMode ? Colors.white : Colors.grey;
                          }),
                          value: _timeTracking,
                          groupValue: '15',
                          onChanged: (value) {
                            _settingsBundlePlugin.set('tracking_type', '15');
                          },
                        ),
                        Text(
                          'Per 15 minutes',
                          style: valueStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String?>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          value: _timeTracking,
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue;
                            }
                            return _isDarkMode ? Colors.white : Colors.grey;
                          }),
                          groupValue: '30',
                          onChanged: (value) {
                            _settingsBundlePlugin.set('tracking_type', '30');
                          },
                        ),
                        Text(
                          'Per 30 minutes',
                          style: valueStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String?>(
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          fillColor: MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors.blue;
                            }
                            return _isDarkMode ? Colors.white : Colors.grey;
                          }),
                          value: _timeTracking,
                          groupValue: '60',
                          onChanged: (value) {
                            _settingsBundlePlugin.set('tracking_type', '60');
                          },
                        ),
                        Text(
                          'Per 1 hour',
                          style: valueStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Gravity',
                style: labelStyle,
              ),
              Slider(
                min: 0,
                max: 1,
                value: _gravity,
                onChanged: (value) {
                  _settingsBundlePlugin.set('slider_preference', value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
