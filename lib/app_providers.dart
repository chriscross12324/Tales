// ignore_for_file: unused_element

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_provider_classes.dart';

///Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

///App Settings
///
/// Appearance
final settingThemeProvider = StateNotifierProvider<BoolProvider, bool>((ref) {
  return BoolProvider(ref
      .read(sharedPreferencesProvider)
      .tryGetBool("settingDarkTheme", true));
});

final settingDisableAnimationsProvider = StateNotifierProvider<BoolProvider, bool>((ref) {
  return BoolProvider(ref
      .read(sharedPreferencesProvider)
      .tryGetBool("settingDisableAnimations", false));
});


///App Settings
///
/// Experience
final showProjectLayout = StateNotifierProvider<BoolProvider, bool>((ref) {
  return BoolProvider(false);
});

final settingAutocorrect = StateNotifierProvider<BoolProvider, bool>((ref) {
  return BoolProvider(ref
      .read(sharedPreferencesProvider)
      .tryGetBool("settingAutocorrect", true));
});

final projectDirectoryPath = StateNotifierProvider<StringProvider, String>((ref) {
  return StringProvider(ref.read(sharedPreferencesProvider).tryGetString("projectDirectoryPath", "NULL"));
});

extension on SharedPreferences {
  int tryGetInt(String key, int defaultVal) {
    try {
      return getInt(key) ?? defaultVal;
    } catch (E) {
      debugPrint("ERROR | File: app_providers.dart | Extension: tryGetInt | "
          "Tag: '$defaultVal' | MSG: ${E.toString()}");
      return defaultVal;
    }
  }

  String tryGetString(String key, String defaultVal) {
    try {
      return getString(key) ?? defaultVal;
    } catch (E) {
      debugPrint("ERROR | File: app_providers.dart | Extension: tryGetString | "
          "Tag: '$defaultVal' | MSG: ${E.toString()}");
      return defaultVal;
    }
  }

  bool tryGetBool(String key, bool defaultVal) {
    try {
      return getBool(key) ?? defaultVal;
    } catch (E) {
      debugPrint("ERROR | File: app_providers.dart | Extension: tryGetBool | "
          "Tag: '$defaultVal' | MSG: ${E.toString()}");
      return defaultVal;
    }
  }
}
