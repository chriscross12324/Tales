import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tales/Dialogs/dialog_help.dart';
import 'package:tales/Dialogs/dialog_message.dart';
import 'package:tales/Dialogs/dialog_new_project.dart';
import 'package:tales/Dialogs/dialog_settings.dart';
import 'package:tales/Dialogs/system_dialog.dart';
import 'package:tales/UniversalWidgets/custom_buttons.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

class PageStarting extends ConsumerWidget {
  const PageStarting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutReader = ref.watch(app_providers.showProjectLayout.notifier);
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: 250,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(app_constants.borderRadiusS),
                    child: const SingleChildScrollView(
                      child: LeftPane(),
                    ),
                  ),
                ),
                const Gap(app_constants.modulePadding),
                const SettingsHelp(),
              ],
            ),
          ),
          const Gap(app_constants.modulePadding),
          Expanded(
            child: CustomContainer(
              bodyColour: theme.secondBackground,
              borderRadius: app_constants.borderRadiusS,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        layoutReader.updateState(true);
                      },
                      child: Text(
                        "Empty",
                        style: TextStyle(
                            color: theme.thirdText, fontSize: 38, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Looks like you don't have any\nprojects yet.",
                      style: TextStyle(color: theme.fourthText, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20),
                    Text(
                      listProjectsInDirectory(ref.watch(app_providers.projectDirectoryPath))
                          .toString(),
                      style: TextStyle(color: theme.fourthText.withOpacity(0.25), fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeftPane extends ConsumerWidget {
  const LeftPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Column(
      children: [
        CustomContainer(
          height: 225,
          width: double.infinity,
          bodyColour: theme.secondBackground,
          borderRadius: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logos/logo_placeholder.png",
                height: 72,
                width: 72,
              ),
              const Gap(24),
              Text(
                "Tales",
                style: TextStyle(color: theme.firstText, fontSize: 32),
                textAlign: TextAlign.center,
              ),
              const Gap(4),
              Text(
                "Write something NEW, CREATIVE and EXPRESSIVE.",
                style: TextStyle(color: theme.thirdText, fontSize: 11),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        const Gap(8),
        GestureDetector(
            onTap: () {
              showStandardDialog(context, ref, const DialogNewProject());
            },
            child: ButtonDialogSecondary(
              buttonText: 'New Project',
            ) /*CustomContainer(
            height: 40,
            bodyColour: theme.secondBackground,
            borderRadius: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/icon_add.svg",
                    height: 18,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      theme.firstText,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    "New Project",
                    style: TextStyle(color: theme.secondText),
                  ),
                ],
              ),
            ),
          ),*/
            ), /*
        const Gap(8),
        GestureDetector(
          onTap: () {
            layoutReader.updateState(true);
          },
          child: CustomContainer(
            height: 40,
            bodyColour: theme.secondBackground,
            borderRadius: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/icon_folder.svg",
                    height: 18,
                    width: 18,
                    colorFilter: ColorFilter.mode(
                      theme.firstText,
                      BlendMode.srcIn,
                    ),
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
        ),*/
      ],
    );
  }
}

class RightPaneProjectOpen extends StatelessWidget {
  const RightPaneProjectOpen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class RightPaneProjectNew extends StatelessWidget {
  const RightPaneProjectNew({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SettingsHelp extends ConsumerWidget {
  const SettingsHelp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            ///Open Settings Dialog
            showStandardDialog(context, ref, const DialogSettings());
          },
          child: ButtonIcon(
            buttonIcon: 'assets/icons/icon_settings.svg',
          ),
        ),
        GestureDetector(
          onTap: () {
            ///Open Settings Dialog
            showStandardDialog(context, ref, const DialogHelp());
          },
          child: ButtonIcon(
            buttonIcon: 'assets/icons/icon_help.svg',
          ),
        ),
      ],
    );
  }
}

List<String> listProjectsInDirectory(String path) {
  List<String> folderNames = [];
  try {
    final parentDirectory = Directory(path);
    final childDirectories = parentDirectory.listSync();

    for (var entity in childDirectories) {
      if (entity is Directory) {
        folderNames.add(entity.path);
      }
    }
  } catch (e) {
    folderNames.add(e.toString());
  }

  return folderNames;
}