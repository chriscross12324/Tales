import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_providers.dart';

class IntProvider extends StateNotifier<int> {
  IntProvider(int defaultValue) : super(defaultValue);

  void updateState(int newState) {
    state = newState;
  }

  void saveState(int newState, String sharedPreferencesKey, WidgetRef ref) {
    try {
      ///Save State
      ref
          .read(sharedPreferencesProvider)
          .setInt(sharedPreferencesKey, newState);

      ///Set State
      updateState(newState);
    } catch (E) {
      ///Show Error
      debugPrint("ERROR | File: app_provider_classes.dart | Class: IntProvider | "
          "Function: saveState() | MSG: ${E.toString()}");
    }
  }

  int getValue() {
    return state;
  }
}

class DoubleProvider extends StateNotifier<double> {
  DoubleProvider(double state) : super(state);

  void updateState(double newState) {
    state = newState;
  }

  void saveState(double newState, String sharedPreferencesKey, WidgetRef ref) {
    try {
      ///Save State
      ref
          .read(sharedPreferencesProvider)
          .setDouble(sharedPreferencesKey, newState);

      ///Set State
      updateState(newState);
    } catch (E) {
      ///Show Error
      debugPrint(
          "ERROR | File: app_provider_classes.dart | Class: DoubleProvider | "
          "Function: saveState() | MSG: ${E.toString()}");
    }
  }

  double getValue() {
    return state;
  }
}

class StringProvider extends StateNotifier<String> {
  StringProvider(String state) : super(state);

  void updateState(String newState) {
    state = newState;
  }

  void saveState(String newState, String sharedPreferencesKey, WidgetRef ref) {
    try {
      ///Save State
      ref
          .read(sharedPreferencesProvider)
          .setString(sharedPreferencesKey, newState);

      ///Set State
      updateState(newState);
    } catch (E) {
      ///Show Error
      debugPrint(
          "ERROR | File: app_provider_classes.dart | Class: StringProvider | "
          "Function: saveState() | MSG: ${E.toString()}");
    }
  }

  String getValue() {
    return state;
  }
}

class BoolProvider extends StateNotifier<bool> {
  BoolProvider(bool state) : super(state);

  void updateState(bool newState) {
    state = newState;
  }

  void saveState(bool newState, String sharedPreferencesKey, WidgetRef ref) {
    try {
      ///Save State
      ref
          .read(sharedPreferencesProvider)
          .setBool(sharedPreferencesKey, newState);

      ///Set State
      updateState(newState);
    } catch (E) {
      ///Show Error
      debugPrint("ERROR | File: app_provider_classes.dart | Class: BoolProvider | "
          "Function: saveState() | MSG: ${E.toString()}");
    }
  }

  bool getValue() {
    return state;
  }
}

class MapStringProvider extends StateNotifier<Map<String, dynamic>> {
  MapStringProvider(Map<String, dynamic> state) : super(state);

  void replaceState(Map<String, dynamic> replaceState) {
    state = replaceState;
  }

  void updateMapState(String mapName, dynamic newValue) {
    try {
      state = {...state, ...{mapName: newValue}};
    } catch(E) {
      debugPrint("ERROR | File: app_provider_classes.dart | Class: MapStringProvider | "
          "Function: updateMapState() | MSG: ${E.toString()}");
    }
  }

  Map<String, dynamic> getValue() {
    return state;
  }
}

class ListWidgetProvider extends StateNotifier<List<Widget>> {
  ListWidgetProvider() : super([]);

  void updateState(List<Widget> newState) {
    state = newState;
  }

  void removeElement(Key key) {
    state = state.where((element) => element.key != key).toList();
  }

  List<Widget> getValue() {
    return state;
  }
}
