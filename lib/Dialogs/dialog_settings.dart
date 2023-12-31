import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:system_theme/system_theme.dart';
import 'package:tales/Dialogs/dialog_action.dart';
import 'package:tales/Dialogs/dialog_message.dart';
import 'package:tales/Dialogs/system_dialog.dart';
import 'package:tales/UniversalWidgets/custom_animated_container.dart';
import 'package:tales/UniversalWidgets/custom_button_list_tile.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';
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
                                child: CustomSwitchListTile(
                                  title: 'Dark Theme',
                                  message:
                                      'Gives the application a darker appearance to make it easier on the eyes in dark environments.',
                                  sharedPreferencesKey: "settingDarkTheme",
                                  boolProvider: app_providers.settingThemeProvider,
                                ),
                              ),
                            ),
                            const Gap(25),
                            Text(
                              "Storage",
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
                                child: CustomButtonListTile(
                                  title: "Project Directory",
                                  message: 'Projects will be stored in:\n$projectDirectoryWatcher',
                                  buttonText: "Select Directory",
                                  buttonFunction: () async {
                                    ///Prompt user to select Directory
                                    FilePicker.platform
                                        .getDirectoryPath()
                                        .then((selectedPath) {
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
                                        checkProjectDirectory(
                                                context, ref, selectedPath)
                                            .then(
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
                                                  moveProjects(ref, selectedPath);
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
                              ),
                            ),
                            const Gap(25),
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
                              bodyColour: SystemTheme.accentColor.accent,
                              borderRadius: app_constants.borderRadiusM,
                              child: Center(
                                child: Text(
                                  "Close",
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

Future<void> moveProjects(WidgetRef ref, String newPath) async {
  final projectDirectoryReader = ref.watch(app_providers.projectDirectoryPath.notifier);
  projectDirectoryReader.saveState(newPath, "projectDirectoryPath", ref);
}

Future<void> checkProjectDirectory(
    BuildContext context, WidgetRef ref, String newPath) async {
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
