import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_providers.dart';

class IntProvider extends StateNotifier<int> {
  IntProvider(int defaultValue) : super(defaultValue);

  void updateState(int newState, {String? sharedPrefsKey, WidgetRef? ref}) {
    try {
      if (sharedPrefsKey != null && ref != null) {
        ///Save
        ref.watch(sharedPreferencesProvider).setInt(sharedPrefsKey, newState);
      }
      state = newState;
    } catch (e) {
      debugPrint("ERROR | File: app_provider_classes.dart | Class: IntProvider | "
          "Function: updateState() | MSG: ${e.toString()} :: $newState :: $sharedPrefsKey :: $ref");
    }
  }

  int getValue() => state;
}

class DoubleProvider extends StateNotifier<double> {
  DoubleProvider(double defaultValue) : super(defaultValue);

  void updateState(double newState, {String? sharedPrefsKey, WidgetRef? ref}) {
    try {
      if (sharedPrefsKey != null && ref != null) {
        ///Save
        ref.watch(sharedPreferencesProvider).setDouble(sharedPrefsKey, newState);
      }
      state = newState;
    } catch (e) {
      debugPrint("ERROR | File: app_provider_classes.dart | Class: DoubleProvider | "
          "Function: updateState() | MSG: ${e.toString()} :: $newState :: $sharedPrefsKey :: $ref");
    }
  }

  double getValue() => state;
}

class BoolProvider extends StateNotifier<bool> {
  BoolProvider(bool defaultValue) : super(defaultValue);

  void updateState(bool newState, {String? sharedPrefsKey, WidgetRef? ref}) {
    try {
      if (sharedPrefsKey != null && ref != null) {
        ///Save
        ref.watch(sharedPreferencesProvider).setBool(sharedPrefsKey, newState);
      }
      state = newState;
    } catch (e) {
      debugPrint("ERROR | File: app_provider_classes.dart | Class: BoolProvider | "
          "Function: updateState() | MSG: ${e.toString()} :: $newState :: $sharedPrefsKey :: $ref");
    }
  }

  bool getValue() => state;
}

class StringProvider extends StateNotifier<String> {
  StringProvider(String defaultValue) : super(defaultValue);

  void updateState(String newState, {String? sharedPrefsKey, WidgetRef? ref}) {
    try {
      if (sharedPrefsKey != null && ref != null) {
        ///Save
        ref.watch(sharedPreferencesProvider).setString(sharedPrefsKey, newState);
      }
      state = newState;
    } catch (e) {
      debugPrint("ERROR | File: app_provider_classes.dart | Class: StringProvider | "
          "Function: updateState() | MSG: ${e.toString()} :: $newState :: $sharedPrefsKey :: $ref");
    }
  }

  String getValue() => state;
}