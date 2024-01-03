import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart' as path;
import 'package:tales/Dialogs/dialog_action.dart';
import 'package:tales/Dialogs/dialog_error.dart';
import 'package:tales/Dialogs/dialog_message.dart';
import 'package:tales/Dialogs/dialog_new_project.dart';
import 'package:tales/Dialogs/system_dialog.dart';
import 'package:tales/UniversalWidgets/custom_animated_container.dart';
import 'package:tales/UniversalWidgets/custom_button_list_tile.dart';
import 'package:tales/UniversalWidgets/custom_buttons.dart';
import 'package:tales/UniversalWidgets/custom_list_separator.dart';
import 'package:tales/UniversalWidgets/custom_switch_list_tile.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

class DialogSettings extends ConsumerWidget {
  const DialogSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectLayoutWatcher = ref.watch(app_providers.showProjectLayout);
    final projectDirectoryWatcher = ref.watch(app_providers.projectDirectoryPath);
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
                            const Gap(25),
                            Text(
                              "Appearance",
                              style: TextStyle(
                                color: theme.firstText,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(10),
                            AnimatedCustomContainer(
                              bodyColour: theme.fourthBackground,
                              borderColour: theme.fourthOutline,
                              borderWidth: 2,
                              borderRadius: app_constants.borderRadiusM,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    CustomSwitchListTile(
                                      title: 'Dark Theme',
                                      message:
                                          'Gives the application a darker appearance to make it easier on the eyes in dark environments.',
                                      sharedPreferencesKey: "settingDarkTheme",
                                      boolProvider: app_providers.settingThemeProvider,
                                    ),
                                    const CustomListSeparator(),
                                    CustomSwitchListTile(
                                      title: 'Disable Animations',
                                      message:
                                          'Disables most animations that occur to speed up actions and remove possible distractions.',
                                      sharedPreferencesKey: "settingDisableAnimations",
                                      boolProvider: app_providers.settingDisableAnimationsProvider,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(25),
                            Text(
                              "Experience",
                              style: TextStyle(
                                color: theme.firstText,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(10),
                            AnimatedCustomContainer(
                              bodyColour: theme.fourthBackground,
                              borderColour: theme.fourthOutline,
                              borderWidth: 2,
                              borderRadius: app_constants.borderRadiusM,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    CustomSwitchListTile(
                                      title: "Autocorrect",
                                      message:
                                          'This feature will automatically suggest or correct misspelled words or typos. Names and uncommon words may be incorrectly changed.',
                                      boolProvider: app_providers.settingAutocorrect,
                                      sharedPreferencesKey: "settingAutocorrect",
                                    ),
                                    const CustomListSeparator(),
                                    CustomButtonListTile(
                                      title: "Project Directory",
                                      message:
                                          'Projects will be stored in:\n$projectDirectoryWatcher',
                                      buttonText: "Select",
                                      buttonFunction: () {
                                        selectNewDirectory(context, ref);
                                      },
                                      disabled: projectLayoutWatcher,
                                    ),
                                  ],
                                ),
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
                            child: ButtonDialogPrimary(
                              buttonText: 'Close',
                              buttonWidth: 150,
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

Future<void> selectNewDirectory(BuildContext context, WidgetRef ref) async {
  String? selectedPath;
  bool userContinue = true;

  ///Prompt user to select folder
  await FilePicker.platform.getDirectoryPath().then((result) => selectedPath = result);

  ///Check if user cancelled
  if (selectedPath == null) {
    if (context.mounted) {
      showStandardDialog(
        context,
        ref,
        const DialogMessage(
          "Cancelled",
          "The dialog was dismissed before a directory was selected and the process has been cancelled.",
          "Ok",
        ),
      );
    }
    return;
  }

  ///Check if selected directory is in container
  if (selectedPath!.toLowerCase().trim().contains('com.simple.tales')) {
    if (context.mounted) {
      await showAsyncDialog(
        context,
        ref,
        DialogAction(
          "Warning",
          "The directory you selected is contained within Tales, therefore all projects will be deleted if Tales is ever uninstalled. It's recommended to select a different directory (ex. Documents, Desktop, etc.).",
          "Continue",
          "Cancel",
          () {

          },
          () {
            userContinue = false;
          },
        ),
      );
    }
  }

  ///Continue with setting new directory
  if (userContinue && context.mounted) {
    setNewProjectDirectory(context, ref, selectedPath!);
  }
}

void projectMigrationError(BuildContext context, WidgetRef ref, String errorMessage) {
  if (context.mounted) {
    showStandardDialog(
      context,
      ref,
      DialogError(errorMessage),
    );
  }
}

Future<void> setNewProjectDirectory(BuildContext context, WidgetRef ref, String newPath) async {
  final currentProjectDirectory = ref.watch(app_providers.projectDirectoryPath);
  final requestedProjectDirectory = path.join(newPath, app_constants.folderName);

  if (doesDirectoryExist(currentProjectDirectory)) {
    ///Migrate Existing
    String? result = await migrateNewProjectDirectory(
        context, ref, currentProjectDirectory, requestedProjectDirectory);
    if (result != null) {
      ///Failed
      if (context.mounted) {
        projectMigrationError(context, ref, result);
      }
      return;
    }
  } else {
    ///Create New
    String? result = await createNewProjectDirectory(context, ref, requestedProjectDirectory);
    if (result != null) {
      ///Failed
      if (context.mounted) {
        projectMigrationError(context, ref, result);
      }
      return;
    }
  }

  ///Update Stored Directory
  ref.watch(app_providers.projectDirectoryPath.notifier).saveState(
        requestedProjectDirectory,
        "projectDirectoryPath",
        ref,
      );

  ///Show Success Dialog
  if (context.mounted) {
    showStandardDialog(
      context,
      ref,
      const DialogMessage(
        "Directory Changed",
        "The directory you selected will now hold any existing and future projects.",
        "Thanks!",
      ),
    );
  }
}

Future<String?> migrateNewProjectDirectory(
    BuildContext context, WidgetRef ref, String currentPath, String newPath) async {
  await showAsyncDialog(
    context,
    ref,
    DialogMessage(
      "Project Migration",
      "The '${app_constants.folderName}' folder and all folders/files contained within are going to be relocated.\n\nFrom: $currentPath\nTo: $newPath",
      "Ok",
    ),
  );

  ///Move to new directory
  try {
    Directory(currentPath).renameSync(newPath);
  } catch (e) {
    return e.toString();
  }

  return null;
}

Future<String?> createNewProjectDirectory(
    BuildContext context, WidgetRef ref, String newPath) async {
  ///null equals GOOD, anything else is an error :(
  await showAsyncDialog(
    context,
    ref,
    const DialogMessage(
      "New Folder",
      "A new folder labelled '${app_constants.folderName}' is going to be created at your chosen location.'",
      "Ok",
    ),
  );

  ///Create Folder if it doesn't exist
  final directory = Directory(newPath);
  if (await directory.exists()) {
    return "The requested directory ($newPath) already exists.";
  }

  try {
    await directory.create(recursive: true);
  } catch (e) {
    return e.toString();
  }

  return null;
}

bool doesDirectoryExist(String path) {
  Directory directory = Directory(path);
  return directory.existsSync();
}
