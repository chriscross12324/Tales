import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tales/Dialogs/dialog_confirm.dart';
import 'package:tales/Pages/page_starting.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';
import 'package:tales/UniversalWidgets/custom_single_child_scroll_view.dart';
import 'package:tales/UniversalWidgets/resizable_pane.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import '../Dialogs/system_dialog.dart';

class PageProject extends ConsumerWidget {
  const PageProject({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

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
              leftWidget: const NavigationPane(),
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

class NavigationPane extends ConsumerWidget {
  const NavigationPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return CustomContainer(
      height: double.infinity,
      bodyColour: theme.secondBackground,
      borderRadiusCustom: const [
        app_constants.borderRadiusM,
        app_constants.borderRadiusM,
        app_constants.borderRadiusS,
        app_constants.borderRadiusM,
      ],
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            CustomContainer(
              height: 30,
              bodyColour: theme.thirdBackground,
              borderRadius: app_constants.borderRadiusS,
              child: Stack(
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Tales",
                            style: TextStyle(
                              color: theme.firstText,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: " - Who We Are",
                            style: TextStyle(
                              color: theme.secondText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        ///Close Project
                        showStandardDialog(
                          context,
                          ref,
                          DialogConfirm(
                            "Exit Project",
                            "You are about to close the project. Are you sure you want to continue?",
                            "Back",
                            () {
                              ref
                                  .watch(app_providers.showProjectLayout.notifier)
                                  .updateState(false);
                            },
                            () {},
                          ),
                        );
                      },
                      child: Container(
                        width: 30,
                        color: Colors.transparent,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/icon_close.svg",
                            height: 14,
                            width: 14,
                            colorFilter: ColorFilter.mode(
                              theme.secondText,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Expanded(
              child: CustomSingleChildScrollView(
                children: [],
              ),
            ),
            const Gap(app_constants.modulePadding),
            const SettingsHelp(),
          ],
        ),
      ),
    );
  }
}
