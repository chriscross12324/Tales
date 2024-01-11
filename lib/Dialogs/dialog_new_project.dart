import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tales/Dialogs/dialog_action.dart';
import 'package:tales/Dialogs/dialog_error.dart';
import 'package:tales/Dialogs/dialog_message.dart';
import 'package:tales/Dialogs/dialog_settings.dart';
import 'package:tales/Dialogs/system_dialog.dart';
import 'package:tales/UniversalWidgets/custom_animated_container.dart';
import 'package:tales/UniversalWidgets/custom_buttons.dart';
import 'package:tales/UniversalWidgets/custom_text_form_field_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_templates.dart';
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;
import 'package:xml/xml.dart';

class DialogNewProject extends ConsumerWidget {
  const DialogNewProject({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingDarkThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    final textControllerProjectName = TextEditingController();
    final textControllerDescription = TextEditingController();
    final textControllerCopyrightHolder = TextEditingController();

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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Project Name",
                                    style: TextStyle(
                                      color: theme.firstText,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: " *",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(5),
                            CustomTextFormField(
                              borderRadius: app_constants.borderRadiusM,
                              bodyColour: theme.fourthBackground,
                              borderColour: theme.fourthOutline,
                              textEditingController: textControllerProjectName,
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
                              textEditingController: textControllerDescription,
                              textInputAction: TextInputAction.next,
                            ),
                            const Gap(5),
                            Text(
                              "Here is where you give a brief description of your project. No need to go into much detail, that’s what will happen later!",
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
                              textEditingController: textControllerCopyrightHolder,
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
                            child: ButtonDialogSecondary(
                              buttonText: 'Cancel',
                              buttonWidth: 150,
                            ),
                          ),
                          const Gap(app_constants.modulePadding),
                          GestureDetector(
                            onTap: () async {
                              initiateProjectCreation(
                                context,
                                ref,
                                textControllerProjectName.value.text,
                                textControllerDescription.value.text,
                                textControllerCopyrightHolder.value.text,
                              );
                            },
                            child: ButtonDialogPrimary(
                              buttonText: 'Create Project',
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

Future<void> initiateProjectCreation(BuildContext context, WidgetRef ref, String projectName,
    String projectDescription, String projectCopyrightHolder) async {
  ///Check if name was provided
  if (projectName.trim().isEmpty) {
    showStandardDialog(
      context,
      ref,
      const DialogMessage(
        "Missing Info",
        "The \"Project Name\" field is empty. Please fill in the field to continue.",
        "Ok",
      ),
    );
    return;
  }

  String talesProjectPath = ref.watch(app_providers.settingProjectsPathProvider);

  ///Check if Project directory is set
  if (!doesDirectoryExist(talesProjectPath)) {
    showStandardDialog(
      context,
      ref,
      DialogAction(
        "Setup Directory",
        "Tales needs to have a directory in order to store projects. Please visit Settings to setup the \"Project Directory\"",
        "Open Settings",
        "Cancel",
        () {
          ///Open Settings Dialog
          showStandardDialog(context, ref, const DialogSettings());
        },
        () {},
      ),
    );
    return;
  }

  ///Create Project
  String? createProjectResult = await createProject(
      talesProjectPath, projectName, projectDescription, projectCopyrightHolder);
  if (createProjectResult != null) {
    if (context.mounted) {
      showStandardDialog(
        context,
        ref,
        DialogError(createProjectResult),
      );
    }
    return;
  }

  ///Remove any open dialogs
  if (context.mounted) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  ///Display Success
  if (context.mounted) {
    showStandardDialog(
      context,
      ref,
      DialogAction(
        "Project Created",
        "Your project has successfully been created!\n\nWould you like to open the project now?",
        "Open",
        "Close",
        () {
          ///Open Project File
        },
        () {},
      ),
    );
  }
}

Future<String?> createProject(String projectLocation, String projectName, String projectDescription,
    String projectCopyrightHolder) async {
  ///Create Project Folder
  String? folderCreationResult = await createFolder(projectLocation, projectName);
  if (folderCreationResult != null) {
    return folderCreationResult;
  }

  ///Create Project Structure File
  String? projectStructureResult = await createFile(
      path.join(projectLocation, projectName), 'config.tale_struct', templateProjectStructureXML());
  if (projectStructureResult != null) {
    return projectStructureResult;
  }

  ///Create Project Files/Folders
  final document = XmlDocument.parse(templateProjectStructureXML());
  final entries = document.findAllElements('entry');
  debugPrint('Length: ${entries.length}');
  for (var entry in entries) {
    final type = entry.getAttribute('type');
    final extension = entry.getAttribute('extension');
    final name = entry.innerText;

    if (type == 'file') {
      String? fileResult = await createFile(
        path.join(projectLocation, projectName),
        name,
        templateOverviewXML(
          projectName,
          projectDescription,
          projectCopyrightHolder,
          DateTime.now().toUtc().toString(),
        ),
      );
      if (fileResult != null) {
        return fileResult;
      }
    } else if (type == 'folder') {
      String? folderResult = await createFolder(path.join(projectLocation, projectName), name);
      if (folderResult != null) {
        return folderResult;
      }

      String? folderStructResult = await createFile(path.join(projectLocation, projectName, name),
          'config.tale_struct', templateSubFolderStructureXML(extension!));
      if (folderStructResult != null) {
        return folderStructResult;
      }
    }
  }

  return null;
}

Future<String?> createFolder(String folderPath, String folderName) async {
  ///Create Folder
  final projectFolder = Directory("$folderPath/$folderName");

  ///Create Folder if it doesn't exist
  if (!(await projectFolder.exists())) {
    try {
      await projectFolder.create(recursive: true);
      return null;
    } catch (e) {
      return 'Folder Creation: ${e.toString()}';
    }
  }
  return "The requested folder already exists: createFolder($folderPath, $folderName)";
}

Future<String?> createFile(String filePath, String fileName, String? fileContent) async {
  ///Create File
  final projectFile = File(path.join(filePath, fileName));

  if (!(await projectFile.exists())) {
    try {
      if (fileContent == null) {
        projectFile.create();
      } else {
        projectFile.writeAsStringSync(fileContent);
      }
      return null;
    } catch (e) {
      return 'File Creation: ${e.toString()}';
    }
  }
  return "The requested file already exists: createFile($filePath, $fileName, ...)";
}
