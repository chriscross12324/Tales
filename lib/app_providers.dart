// ignore_for_file: unused_element

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_provider_classes.dart';

///Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

///Appearance Setting Providers
final settingDarkThemeProvider = StateNotifierProvider<BoolProvider, bool>((ref) {
  return BoolProvider(ref.read(sharedPreferencesProvider).tryGetValue("settingDarkTheme", true));
});
final settingDisableAnimationsProvider = StateNotifierProvider<BoolProvider, bool>((ref) {
  return BoolProvider(
      ref.read(sharedPreferencesProvider).tryGetValue("settingDisableAnimations", false));
});

///Experience Setting Providers
final settingAutocorrectProvider = StateNotifierProvider<BoolProvider, bool>((ref) {
  return BoolProvider(ref.read(sharedPreferencesProvider).tryGetValue("settingAutocorrect", true));
});
final settingProjectsPathProvider = StateNotifierProvider<StringProvider, String>((ref) {
  return StringProvider(
      ref.read(sharedPreferencesProvider).tryGetValue("settingProjectsPath", "Not Configured"));
});

///Other Providers
final currentProjectProvider = StateNotifierProvider<StringProvider, String>((ref) {
  return StringProvider("");
});

extension on SharedPreferences {
  T? tryGetValue<T>(String key, defaultValue) {
    try {
      return get(key) ?? defaultValue;
    } catch (e) {
      debugPrint("ERROR | File: app_providers.dart | Extension: tryGetValue | "
          "Tag: '$defaultValue' | MSG: ${e.toString()}");
      return defaultValue;
    }
  }
}
