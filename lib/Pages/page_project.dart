import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';
import 'package:tales/UniversalWidgets/resizable_pane.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import '../Dialogs/dialog_action.dart';
import '../Dialogs/dialog_settings.dart';
import '../Dialogs/system_dialog.dart';

class PageProject extends ConsumerWidget {
  const PageProject({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final themeReader = ref.watch(app_providers.settingThemeProvider.notifier);
    final theme = app_themes.theme(themeWatcher, ref);

    final layoutReader = ref.watch(app_providers.showProjectLayout.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          CustomContainer(
            height: 50,
            width: double.infinity,
            bodyColour: theme.secondBackground,
            borderRadius: app_constants.borderRadiusM,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(app_constants.modulePadding / 2),
                child: Row(
                  children: [
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                    CustomContainer(
                      width: 100,
                      bodyColour: theme.thirdBackground,
                      borderRadius: app_constants.borderRadiusS,
                    ),
                    const Gap(app_constants.modulePadding / 2),
                  ],
                ),
              ),
            ),
          ),
          const Gap(app_constants.modulePadding),
          Expanded(
            child: ResizablePane(
              leftWidget: CustomContainer(
                height: double.infinity,
                bodyColour: theme.secondBackground,
                borderRadiusCustom: const [
                  app_constants.borderRadiusM,
                  app_constants.borderRadiusM,
                  app_constants.borderRadiusS,
                  app_constants.borderRadiusM,
                ],
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(app_constants.borderRadiusS),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomContainer(
                                height: 40,
                                bodyColour: theme.secondBackground,
                                borderRadius: 5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/icon_add.svg",
                                        color: theme.firstText,
                                        height: 18,
                                        width: 18,
                                      ),
                                      const Gap(8),
                                      Text(
                                        "New Project",
                                        style: TextStyle(color: theme.secondText),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(8),
                              CustomContainer(
                                height: 40,
                                bodyColour: theme.secondBackground,
                                borderRadius: 5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/icon_folder.svg",
                                        color: theme.firstText,
                                        height: 18,
                                        width: 18,
                                      ),
                                      const Gap(8),
                                      Text(
                                        "Open",
                                        style: TextStyle(color: theme.secondText),
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
                    const Gap(app_constants.modulePadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showStandardDialog(context, ref, const DialogSettings());
                          },
                          child: CustomContainer(
                            height: 40,
                            width: 40,
                            bodyColour: Colors.transparent,
                            borderRadius: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                "assets/icons/icon_settings.svg",
                                color: theme.secondText,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showStandardDialog(
                              context,
                              ref,
                              DialogAction(
                                "Exit Project",
                                "Continuing will close this project and return you to the 'Welcome' screen.",
                                "Close Project",
                                "Cancel",
                                () {
                                  layoutReader.updateState(false);
                                },
                                () {},
                              ),
                            );
                          },
                          child: CustomContainer(
                            height: 40,
                            width: 40,
                            bodyColour: Colors.transparent,
                            borderRadius: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                "assets/icons/icon_help.svg",
                                color: theme.secondText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              rightWidget: CustomContainer(
                height: double.infinity,
                bodyColour: theme.secondBackground,
                borderRadiusCustom: const [
                  app_constants.borderRadiusM,
                  app_constants.borderRadiusM,
                  app_constants.borderRadiusM,
                  app_constants.borderRadiusS,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
