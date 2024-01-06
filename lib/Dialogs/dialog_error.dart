import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';
import 'package:tales/UniversalWidgets/custom_single_child_scroll_view.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import '../UniversalWidgets/custom_buttons.dart';

class DialogError extends ConsumerWidget {
  DialogError(
    this.errorMessage, {
    super.key,
  });

  final String errorMessage;
  final ValueNotifier<String> _buttonCopyText = ValueNotifier("Copy Message");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingDarkThemeProvider);
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
                        "Error",
                        style: TextStyle(
                          color: theme.firstText,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        "An error occurred, to continue Press & Hold the 'Continue' button below.\n\nHere is the error message returned:",
                        style: TextStyle(
                          color: theme.secondText,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Gap(10),
                      CustomContainer(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxHeight: 175),
                        bodyColour: theme.fourthBackground,
                        borderRadius: app_constants.borderRadiusL,
                        child: CustomSingleChildScrollView(
                          borderRadius: app_constants.borderRadiusL,
                          children: [
                            const Gap(10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                errorMessage,
                                style: TextStyle(
                                  color: theme.secondText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const Gap(10),
                          ],
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              ///Run Function
                              Clipboard.setData(ClipboardData(text: errorMessage));

                              ///Update Button Text
                              _buttonCopyText.value = "Copied";
                            },
                            child: ValueListenableBuilder(
                              valueListenable: _buttonCopyText,
                              builder: (BuildContext context, String buttonText, Widget? child) {
                                return ButtonDialogSecondary(
                                  buttonText: buttonText,
                                );
                              },
                            ),
                          ),
                        ),
                        const Gap(app_constants.modulePadding),
                        Expanded(
                          child: ButtonPressHold(
                            buttonText: "Continue",
                            buttonFunction: () {
                              ///Close Dialog
                              Navigator.of(context, rootNavigator: true).pop();
                            },
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
