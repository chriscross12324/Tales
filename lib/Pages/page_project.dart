import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

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
            child: Row(
              children: [
                CustomContainer(
                  height: double.infinity,
                  width: 250,
                  bodyColour: theme.secondBackground,
                  borderRadiusCustom: const [
                    app_constants.borderRadiusM,
                    app_constants.borderRadiusM,
                    app_constants.borderRadiusS,
                    app_constants.borderRadiusM,
                  ],
                ),
                SizedBox(
                  width: app_constants.modulePadding,
                  child: Center(
                    child: CustomContainer(
                      height: 20,
                      width: 4,
                      bodyColour: theme.thirdText,
                      borderRadius: 3,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomContainer(
                    bodyColour: theme.secondBackground,
                    borderRadiusCustom: const [
                      app_constants.borderRadiusM,
                      app_constants.borderRadiusM,
                      app_constants.borderRadiusM,
                      app_constants.borderRadiusS,
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
