import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tales/Dialogs/dialog_action.dart';
import 'package:tales/Dialogs/dialog_help.dart';
import 'package:tales/Dialogs/dialog_message.dart';
import 'package:tales/Dialogs/dialog_new_project.dart';
import 'package:tales/Dialogs/dialog_settings.dart';
import 'package:tales/Dialogs/system_dialog.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import '../Dialogs/dialog_confirm.dart';

class PageStarting extends ConsumerWidget {
  const PageStarting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final layoutReader = ref.watch(app_providers.showProjectLayout.notifier);
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Column(
      children: [
        CustomContainer(
          height: 250,
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
                style: TextStyle(
                    color: theme.firstText, fontSize: 32),
                textAlign: TextAlign.center,
              ),
              const Gap(4),
              Text(
                "Write something NEW, CREATIVE and EXPRESSIVE.",
                style: TextStyle(
                    color: theme.thirdText, fontSize: 11),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        const Gap(8),
        GestureDetector(
          onTap: () {
            showStandardDialog(context, ref, const DialogNewProject());
            /*String? selectedDirectory =
            await FilePicker.platform.getDirectoryPath();
            if (selectedDirectory == null) {
              showStandardDialog(
                context,
                ref,
                DialogMessage(
                    "Action Cancelled",
                    "The dialog was dismissed before a location was selected. Projects won't be able to be created.",
                    "Ok"),
              );
            } else {
              if (selectedDirectory
                  .toLowerCase()
                  .trim()
                  .contains(("containers/com.simple.tales"))) {
                await directoryWarning(context, ref);
              }
              createProject(selectedDirectory, "Who We Are")
                  .then((value) {
                if (value) {
                  showStandardDialog(
                    context,
                    ref,
                    DialogMessage(
                        "Project Created",
                        "The project 'Who We Are' has successfully been created in $selectedDirectory!",
                        "Ok"),
                  );
                } else {
                  showStandardDialog(
                    context,
                    ref,
                    DialogMessage(
                        "Project Already Exists",
                        "The project specified already exists in that location, please enter a different name.",
                        "Ok"),
                  );
                }
              });
            }*/
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
        ),
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
        ),
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
          child: Container(
            height: 40,
            width: 40,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                "assets/icons/icon_settings.svg",
                colorFilter: ColorFilter.mode(theme.secondText, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            ///Open Settings Dialog
            showStandardDialog(context, ref, const DialogHelp());
          },
          child: Container(
            height: 40,
            width: 40,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                "assets/icons/icon_help.svg",
                colorFilter: ColorFilter.mode(theme.secondText, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void createFile(String path) async {
  final file = File("$path/Tales.txt");
  await file.writeAsString("Test");
}

Future<bool> createProject(String projectLocation, String projectName) async {
  ///Create Project Folder
  if (!(await createFolder(projectLocation, projectName))) {
    return false;
  }

  ///Create Project Sub-Folders
  List<String> subfolderNames = [
    "Chapters",
    "Characters",
    "Locations",
    "Research",
    "Recycle Bin"
  ];
  for (String subfolderName in subfolderNames) {
    if (!(await createFolder("$projectLocation/$projectName", subfolderName))) {
      return false;
    }
  }

  return true;
}

Future<bool> createFolder(String folderPath, String folderName) async {
  ///Create Folder
  final projectFolder = Directory("$folderPath/$folderName");

  ///Create Folder if it doesn't exist
  if (!(await projectFolder.exists())) {
    await projectFolder.create(recursive: true);
    return true;
  } else {
    return false;
  }
}

Future<void> directoryWarning(BuildContext context, WidgetRef ref) async {
  showStandardDialog(
    context,
    ref,
    const DialogMessage(
      "Warning",
      "The directory you selected in contained within Tales. All projects will be removed if Tales is ever uninstalled.",
      "I understand",
    ),
  );
}
