import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:system_theme/system_theme.dart';
import 'package:tales/Dialogs/dialog_message.dart';
import 'package:tales/Dialogs/system_dialog.dart';
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
                              textEditingController:
                                  textControllerCopyrightHolder,
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
                            onTap: () async {
                              ///Create Project
                              if (textControllerProjectName
                                  .value.text.isEmpty) {
                                ///Show Error
                                showStandardDialog(
                                  context,
                                  ref,
                                  const DialogMessage(
                                    "Missing Info",
                                    "The 'Project Name' text field is empty. You need to enter text to create a new project.",
                                    "Ok",
                                  ),
                                );
                              } else {
                                ///Show Creation Dialog
                                showStandardDialog(
                                  context,
                                  ref,
                                  const DialogMessage(
                                    "Creating",
                                    "Your project is being created, please wait.",
                                    "",
                                  ),
                                );
                                if (await createProject(
                                    ref.watch(
                                        app_providers.projectDirectoryPath),
                                    textControllerProjectName.value.text)) {
                                  ///Success
                                  showStandardDialog(
                                    context,
                                    ref,
                                    const DialogMessage(
                                      "Project Created",
                                      "Your project has successfully been created!",
                                      "",
                                    ),
                                  );
                                } else {
                                  ///Error
                                  showStandardDialog(
                                    context,
                                    ref,
                                    const DialogMessage(
                                      "Failed",
                                      "Tales encountered an error and you project could not be successfully created!",
                                      "",
                                    ),
                                  );
                                }
                              }
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
