import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;

void showStandardDialog(BuildContext context, WidgetRef ref, Widget dialogLayout) {
  final disableAnimationsWatcher = ref.watch(app_providers.settingDisableAnimationsProvider);
  final themeWatcher = ref.watch(app_providers.settingThemeProvider);
  final theme = app_themes.theme(themeWatcher, ref);

  showGeneralDialog(
    context: context,
    pageBuilder: (_, anim1, anim2) => PopScope(
      canPop: false,
      onPopInvoked: (didPop) => false,
      child: dialogLayout,
    ),
    transitionBuilder: (_, anim1, anim2, dialogLayout) {
      final curvedAnimation =
          CurvedAnimation(parent: anim1, curve: Curves.easeInOutCubic);

      return Transform.scale(
        scale: 1.1 - 0.1 * curvedAnimation.value,
        child: Opacity(
          opacity: curvedAnimation.value,
          child: dialogLayout,
        ),
      );
    },
    transitionDuration: Duration(milliseconds: disableAnimationsWatcher ? 0 : 250),
    barrierColor: theme.firstBackground.withOpacity(themeWatcher ? 0.75 : 0.5),
  );
}

Future<void> showAsyncDialog(BuildContext context, WidgetRef ref, Widget dialogLayout) async {
  final themeWatcher = ref.watch(app_providers.settingThemeProvider);
  final theme = app_themes.theme(themeWatcher, ref);

  await showGeneralDialog(
    context: context,
    pageBuilder: (_, anim1, anim2) => PopScope(
      canPop: false,
      onPopInvoked: (didPop) => false,
      child: dialogLayout,
    ),
    transitionBuilder: (_, anim1, anim2, dialogLayout) {
      final curvedAnimation =
      CurvedAnimation(parent: anim1, curve: Curves.easeInOutCubic);

      return Transform.scale(
        scale: 1.1 - 0.1 * curvedAnimation.value,
        child: Opacity(
          opacity: curvedAnimation.value,
          child: dialogLayout,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 250),
    barrierColor: theme.firstBackground.withOpacity(themeWatcher ? 0.75 : 0.5),
  );
}