import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

class DialogConfirm extends ConsumerWidget {
  const DialogConfirm(
    this.dialogTitle,
    this.dialogBody,
    this.secondaryButtonText,
    this.primaryButtonFunction,
    this.secondaryButtonFunction, {
    super.key,
  });

  final String dialogTitle;
  final String dialogBody;

  final String secondaryButtonText;

  final Function primaryButtonFunction;
  final Function secondaryButtonFunction;

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
                        "$dialogBody\n\nPress & Hold the 'Confirm' button below continue.",
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              ///Run Function
                              secondaryButtonFunction();

                              ///Close Dialog
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: CustomContainer(
                              height: 40,
                              bodyColour: theme.thirdBackground,
                              borderRadius: app_constants.borderRadiusM,
                              child: Center(
                                child: Text(
                                  secondaryButtonText,
                                  style: TextStyle(
                                    color: theme.firstText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(app_constants.modulePadding),
                        Expanded(
                          child: ButtonPressHold(
                            buttonFunction: () {
                              ///Close Dialog
                              Navigator.of(context, rootNavigator: true).pop();

                              ///Run Function
                              primaryButtonFunction();
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

class ButtonPressHold extends ConsumerStatefulWidget {
  const ButtonPressHold({super.key, required this.buttonFunction});

  final Function buttonFunction;

  @override
  ConsumerState<ButtonPressHold> createState() => _ButtonPressHoldState();
}

class _ButtonPressHoldState extends ConsumerState<ButtonPressHold> {
  bool isPressed = false;
  double progressValue = 0.0;
  Timer? progressTimer;

  @override
  Widget build(BuildContext context) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return GestureDetector(
      onTapDown: (_) {
        startProgress();
      },
      onTapUp: (_) {
        resetProgress();
      },
      onTapCancel: () {
        resetProgress();
      },
      child: CustomContainer(
        height: 40,
        bodyColour: const Color(0xFFC40000),
        borderRadius: app_constants.borderRadiusM,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: isPressed ? 0 : 1,
              duration: const Duration(milliseconds: 250),
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: theme.firstText,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: isPressed ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 3,
                    color: theme.firstText,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startProgress() {
    isPressed = true;
    progressTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        if (progressValue < 1.0) {
          progressValue += 0.01;
        } else {
          resetProgress();
          widget.buttonFunction();
        }
      });
    });
  }

  void resetProgress() {
    if (progressTimer != null && progressTimer!.isActive) {
      progressTimer!.cancel();
    }
    setState(() {
      isPressed = false;
      progressValue = 0.0;
    });
  }
}
