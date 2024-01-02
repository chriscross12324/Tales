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
                                      buttonFunction: () async {
                                        ///Prompt user to select Directory
                                        FilePicker.platform.getDirectoryPath().then((selectedPath) {
                                          if (selectedPath == null) {
                                            showStandardDialog(
                                              context,
                                              ref,
                                              const DialogMessage(
                                                "Action Cancelled",
                                                "The dialog was dismissed before a directory was selected. No changes are made.",
                                                "Ok",
                                              ),
                                            );
                                          } else {
                                            checkProjectDirectory(context, ref, selectedPath).then(
                                              (value) {
                                                debugPrint("User Continuing");
                                                showStandardDialog(
                                                  context,
                                                  ref,
                                                  DialogAction(
                                                    "Migrate Projects",
                                                    "A new Project Directory has been selected. Continuing will move already existing projects to the new directory.",
                                                    "Migrate",
                                                    "Cancel",
                                                    () {
                                                      setNewProjectDirectory(
                                                          context, ref, selectedPath);
                                                    },
                                                    () {},
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        });

                                        ///Check if action was cancelled
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

Future<void> moveProjects(BuildContext context, WidgetRef ref, String newPath) async {
  ///Get Current Directory
  final currentProjectDirectory = ref.watch(app_providers.projectDirectoryPath);

  if (!doesDirectoryExist(currentProjectDirectory)) {
    ///Create New Location
    await showAsyncDialog(
      context,
      ref,
      const DialogMessage(
        "Folder Creation",
        "Tales is going to create a new folder called 'TalesProjects', this folder will store all your projects.",
        "Ok",
      ),
    );

    ///Create TalesProjects Folder
    if (!(await createFolder(newPath, "TalesProjects"))) {
      ///Failed
      if (context.mounted) {
        //projectMigrationError(context, ref, null);
      }
      return;
    }
  } else {
    ///Move to New Directory
    try {
      Directory(currentProjectDirectory).renameSync(path.join(newPath, "TalesProjects"));
    } catch (e) {
      projectMigrationError(context, ref, e.toString() + newPath);
      return;
    }
  }
  final projectDirectoryReader = ref.watch(app_providers.projectDirectoryPath.notifier);
  projectDirectoryReader.saveState(
      path.join(newPath, "TalesProjects"), "projectDirectoryPath", ref);

  if (context.mounted) {
    showStandardDialog(
      context,
      ref,
      const DialogMessage(
        "Success",
        "Any existing and future projects will now be found in the new location.",
        "Thanks",
      ),
    );
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

Future<void> checkProjectDirectory(BuildContext context, WidgetRef ref, String newPath) async {
  if (newPath.toLowerCase().trim().contains("com.simple.tales")) {
    await showAsyncDialog(
      context,
      ref,
      const DialogMessage(
        "Warning",
        "The selected directory is contained within Tales, this means if the application is ever uninstalled all Projects will be deleted.\n\nIt's recommended to selected a different directory.",
        //"The directory you selected is contained within Tales, therefore all projects will be deleted if Tales is ever uninstalled. It's recommended to select a directory (ex. Documents, Desktop, etc.).",
        "I understand",
      ),
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
