import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:system_theme/system_theme.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import '../app_provider_classes.dart';
import 'custom_animated_container.dart';

class CustomSwitchListTile extends ConsumerWidget {
  const CustomSwitchListTile({
    Key? key,
    required this.title,
    required this.message,
    required this.boolProvider,
    this.sharedPreferencesKey,
    this.isExperimental = false,
    this.defaultValue,
    this.disabled = false,
  })  : assert(
            (isExperimental == true && defaultValue != null) ||
                isExperimental == false,
            '"isExperimental: true" must be accompanied by a defaultValue'),
        super(key: key);

  final String title;
  final String message;
  final StateNotifierProvider<BoolProvider, bool> boolProvider;
  final String? sharedPreferencesKey;
  final bool isExperimental;
  final bool? defaultValue;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);
    final boolWatcher = ref.watch(boolProvider);
    final boolReader = ref.watch(boolProvider.notifier);

    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: AbsorbPointer(
        absorbing: disabled,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: theme.secondText,
                      fontSize: 16,
                      height: 1.2,
                      fontFamily: "Rounded",
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: TextStyle(
                      color: theme.thirdText,
                      fontSize: 12,
                      height: 1.2,
                      fontFamily: "Rounded",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            AnimatedCustomContainer(
              height: 35,
              width: 80,
              bodyColour: theme.thirdBackground,
              borderRadius: app_constants.borderRadiusM,
              borderRadiusSubtraction: 0,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (sharedPreferencesKey != null) {
                          ///Save Setting
                          boolReader.saveState(false, sharedPreferencesKey!, ref);
                        } else {
                          ///Update Setting
                          boolReader.updateState(false);
                        }
                      },
                      child: AnimatedCustomContainer(
                        height: double.infinity,
                        width: !boolWatcher ? 40 : 31,
                        bodyColour: boolWatcher
                            ? theme.fourthBackground.withOpacity(1)
                            : SystemTheme.accentColor.dark,
                        borderRadiusCustom: const [
                          app_constants.borderRadiusM,
                          app_constants.borderRadiusS,
                          app_constants.borderRadiusM,
                          app_constants.borderRadiusS,
                        ],
                        borderRadiusSubtractionCustom: const [3, 3, 3, 3],
                        duration: const Duration(milliseconds: 150),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: SvgPicture.asset(
                              "assets/icons/icon_close.svg",
                              colorFilter: ColorFilter.mode(
                                boolWatcher ? theme.fourthText : theme.firstText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    GestureDetector(
                      onTap: () {
                        if (sharedPreferencesKey != null) {
                          ///Save Setting
                          boolReader.saveState(true, sharedPreferencesKey!, ref);
                        } else {
                          ///Update Setting
                          boolReader.updateState(true);
                        }
                      },
                      child: AnimatedCustomContainer(
                        height: double.infinity,
                        width: boolWatcher ? 40 : 31,
                        bodyColour: boolWatcher
                            ? SystemTheme.accentColor.accent
                            : theme.fourthBackground.withOpacity(1),
                        borderRadiusCustom: const [
                          app_constants.borderRadiusS,
                          app_constants.borderRadiusM,
                          app_constants.borderRadiusS,
                          app_constants.borderRadiusM,
                        ],
                        borderRadiusSubtractionCustom: const [3, 3, 3, 3],
                        duration: const Duration(milliseconds: 150),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: SvgPicture.asset(
                              "assets/icons/icon_check.svg",
                              colorFilter: ColorFilter.mode(
                                boolWatcher ? theme.firstText : theme.fourthText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
