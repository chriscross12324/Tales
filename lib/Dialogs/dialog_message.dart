import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:system_theme/system_theme.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

class DialogMessage extends ConsumerWidget {
  const DialogMessage(
    this.dialogTitle,
    this.dialogBody,
    this.buttonText, {
    super.key,
  });

  final String dialogTitle;
  final String dialogBody;

  final String buttonText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CustomContainer(
          width: 375,
          bodyColour: theme.thirdBackground,
          borderRadius: app_constants.borderRadiusL,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dialogTitle,
                        style: TextStyle(
                          color: theme.firstText,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        dialogBody,
                        style: TextStyle(
                          color: theme.secondText,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  width: double.infinity,
                  bodyColour: theme.secondBackground,
                  borderRadiusCustom: const [
                    0,
                    0,
                    app_constants.borderRadiusL,
                    app_constants.borderRadiusL
                  ],
                  borderRadiusSubtractionCustom: const [0, 0, 2, 2],
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            ///Close Dialog
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: CustomContainer(
                            height: 40,
                            width: 150,
                            bodyColour: SystemTheme.accentColor.accent,
                            borderRadius: app_constants.borderRadiusM,
                            child: Center(
                              child: Text(
                                buttonText,
                                style: TextStyle(
                                  color: theme.firstText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
