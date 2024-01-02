import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:system_theme/system_theme.dart';
import 'package:tales/UniversalWidgets/custom_animated_container.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';
import 'package:tales/UniversalWidgets/custom_text_form_field_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

class DialogNewProject extends ConsumerWidget {
  const DialogNewProject({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: AnimatedCustomContainer(
            height: 500,
            width: 700,
            bodyColour: theme.thirdBackground,
            borderRadius: app_constants.borderRadiusL,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(20),
                            Text(
                              "Project Name",
                              style: TextStyle(
                                color: theme.firstText,
                                fontSize: 20,
                                fontFamily: "Rounded",
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(5),
                            CustomTextFormField(
                              borderRadius: app_constants.borderRadiusM,
                              bodyColour: theme.fourthBackground,
                              borderColour: theme.fourthOutline,
                              textEditingController: TextEditingController(),
                              textInputAction: TextInputAction.next,
                            ),
                            const Gap(5),
                            Text(
                              "The name of your project. This cannot be changed automatically later.",
                              style: TextStyle(
                                color: theme.thirdText,
                                fontSize: 12,
                                height: 1.2,
                                fontFamily: "Rounded",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(20),
                            Text(
                              "Description",
                              style: TextStyle(
                                color: theme.firstText,
                                fontSize: 20,
                                fontFamily: "Rounded",
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(5),
                            CustomTextFormField(
                              height: 125,
                              borderRadius: app_constants.borderRadiusM,
                              bodyColour: theme.fourthBackground,
                              borderColour: theme.fourthOutline,
                              textEditingController: TextEditingController(),
                              textInputAction: TextInputAction.next,
                            ),
                            const Gap(5),
                            Text(
                              "Here is where you give a brief description of yur project. No need to go into much detail, that’s what will happen later!",
                              style: TextStyle(
                                color: theme.thirdText,
                                fontSize: 12,
                                height: 1.2,
                                fontFamily: "Rounded",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(20),
                            Text(
                              "Copyright Holder",
                              style: TextStyle(
                                color: theme.firstText,
                                fontSize: 20,
                                fontFamily: "Rounded",
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Gap(5),
                            CustomTextFormField(
                              borderRadius: app_constants.borderRadiusM,
                              bodyColour: theme.fourthBackground,
                              borderColour: theme.fourthOutline,
                              textEditingController: TextEditingController(),
                              textInputAction: TextInputAction.next,
                            ),
                            const Gap(5),
                            Text(
                              "This is the name that will be included in the copyright message. This can be your Name, Group Name, or Company.",
                              style: TextStyle(
                                color: theme.thirdText,
                                fontSize: 12,
                                height: 1.2,
                                fontFamily: "Rounded",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedCustomContainer(
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
                              bodyColour: theme.thirdBackground,
                              borderRadius: app_constants.borderRadiusM,
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: theme.firstText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(app_constants.modulePadding),
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
                                  "Create Project",
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
      ),
    );
  }
}
