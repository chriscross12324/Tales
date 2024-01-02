import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:system_theme/system_theme.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import 'custom_animated_container.dart';

class ButtonPressHold extends ConsumerStatefulWidget {
  const ButtonPressHold({super.key, required this.buttonText, required this.buttonFunction});

  final String buttonText;
  final Function buttonFunction;

  @override
  ConsumerState<ButtonPressHold> createState() => _ButtonPressHoldState();
}

class _ButtonPressHoldState extends ConsumerState<ButtonPressHold> {
  bool isPressed = false;
  double progressValue = 0.0;
  Timer? progressTimer;

  final ValueNotifier<bool> _isHovering = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final disableAnimationsWatcher = ref.watch(app_providers.settingDisableAnimationsProvider);
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Listener(
      onPointerDown: (_) {
        startProgress();
      },
      onPointerUp: (_) {
        resetProgress();
      },
      onPointerCancel: (_) {
        resetProgress();
      },
      child: MouseRegion(
        onEnter: (_) {
          _isHovering.value = true;
        },
        onExit: (_) {
          _isHovering.value = false;
        },
        child: ValueListenableBuilder(
          valueListenable: _isHovering,
          builder: (BuildContext context, bool hovered, Widget? child) {
            Color hoveredColour = Color.fromARGB(
              const Color(0xFFC40000).alpha,
              (const Color(0xFFC40000).red * 0.7).round(),
              (const Color(0xFFC40000).green * 0.7).round(),
              (const Color(0xFFC40000).blue * 0.7).round(),
            );

            return AnimatedCustomContainer(
              height: 40,
              bodyColour: hovered ? hoveredColour : const Color(0xFFC40000),
              borderRadius: app_constants.borderRadiusM,
              duration: const Duration(milliseconds: 250),
              child: child,
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                opacity: isPressed ? 0 : 1,
                duration: Duration(milliseconds: disableAnimationsWatcher ? 0 : 250),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: isPressed ? 1 : 0,
                duration: Duration(milliseconds: disableAnimationsWatcher ? 0 : 250),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 3,
                      color: Colors.white,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
              ),
            ],
          ),
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

class ButtonDialogPrimary extends ConsumerWidget {
  ButtonDialogPrimary({super.key, required this.buttonText, this.buttonWidth});

  final String buttonText;
  final double? buttonWidth;
  final ValueNotifier<bool> _isHovering = ValueNotifier(false);
  final ValueNotifier<bool> _isPressed = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Listener(
      onPointerDown: (_) {
        _isPressed.value = true;
      },
      onPointerUp: (_) {
        _isPressed.value = false;
      },
      onPointerCancel: (_) {
        _isPressed.value = false;
      },
      child: MouseRegion(
        onEnter: (_) {
          _isHovering.value = true;
        },
        onExit: (_) {
          _isHovering.value = false;
        },
        child: ValueListenableBuilder(
          valueListenable: _isHovering,
          builder: (BuildContext context, bool hovered, Widget? child) {
            Color hoveredColour = Color.fromARGB(
              SystemTheme.accentColor.accent.alpha,
              (SystemTheme.accentColor.accent.red * 0.7).round(),
              (SystemTheme.accentColor.accent.green * 0.7).round(),
              (SystemTheme.accentColor.accent.blue * 0.7).round(),
            );

            return ValueListenableBuilder(
              valueListenable: _isPressed,
              builder: (BuildContext context, pressed, _) {
                Color pressedColour = Color.fromARGB(
                  SystemTheme.accentColor.accent.alpha,
                  (SystemTheme.accentColor.accent.red * 0.5).round(),
                  (SystemTheme.accentColor.accent.green * 0.5).round(),
                  (SystemTheme.accentColor.accent.blue * 0.5).round(),
                );

                return AnimatedCustomContainer(
                  height: 40,
                  width: buttonWidth,
                  bodyColour: pressed
                      ? pressedColour
                      : hovered
                          ? hoveredColour
                          : SystemTheme.accentColor.accent,
                  borderRadius: app_constants.borderRadiusM,
                  duration: const Duration(milliseconds: 250),
                  child: child,
                );
              },
            );
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonWidth == null ? 15 : 0),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonDialogSecondary extends ConsumerWidget {
  ButtonDialogSecondary({super.key, required this.buttonText, this.buttonWidth});

  final String buttonText;
  final double? buttonWidth;
  final ValueNotifier<bool> _isHovering = ValueNotifier(false);
  final ValueNotifier<bool> _isPressed = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Listener(
      onPointerDown: (_) {
        _isPressed.value = true;
      },
      onPointerUp: (_) {
        _isPressed.value = false;
      },
      onPointerCancel: (_) {
        _isPressed.value = false;
      },
      child: MouseRegion(
        onEnter: (_) {
          _isHovering.value = true;
        },
        onExit: (_) {
          _isHovering.value = false;
        },
        child: ValueListenableBuilder(
          valueListenable: _isHovering,
          builder: (BuildContext context, bool hovered, Widget? child) {
            Color hoveredColour = Color.fromARGB(
              theme.thirdBackground.alpha,
              (theme.thirdBackground.red * 0.8).round(),
              (theme.thirdBackground.green * 0.8).round(),
              (theme.thirdBackground.blue * 0.8).round(),
            );

            return ValueListenableBuilder(
              valueListenable: _isPressed,
              builder: (BuildContext context, bool pressed, _) {
                Color pressedColour = Color.fromARGB(
                  theme.thirdBackground.alpha,
                  (theme.thirdBackground.red * 0.7).round(),
                  (theme.thirdBackground.green * 0.7).round(),
                  (theme.thirdBackground.blue * 0.7).round(),
                );

                return AnimatedCustomContainer(
                  height: 40,
                  width: buttonWidth,
                  bodyColour: pressed
                      ? pressedColour
                      : hovered
                      ? hoveredColour : theme.thirdBackground,
                  borderRadius: app_constants.borderRadiusM,
                  duration: const Duration(milliseconds: 250),
                  child: child,
                );
              },
            );
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonWidth == null ? 15 : 0),
              child: Text(
                buttonText,
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
    );
  }
}
