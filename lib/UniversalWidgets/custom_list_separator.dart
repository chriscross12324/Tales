import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import 'custom_animated_container.dart';

class CustomListSeparator extends ConsumerWidget {
  const CustomListSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return SizedBox(
      height: 30,
      child: Center(
        child: AnimatedCustomContainer(
          height: 2.5,
          width: double.infinity,
          bodyColour: theme.fourthOutline,
          borderRadius: app_constants.borderRadiusS,
        ),
      ),
    );
  }
}
