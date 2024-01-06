import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tales/Dialogs/dialog_help.dart';
import 'package:tales/Dialogs/dialog_new_project.dart';
import 'package:tales/Dialogs/dialog_settings.dart';
import 'package:tales/Dialogs/dialog_waiting.dart';
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
    final projectDirectory = ref.watch(app_providers.projectDirectoryPath);
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
              child: RightPane(
                projectsDirectory: projectDirectory,
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
          ),
        ),
      ],
    );
  }
}

class RightPane extends ConsumerStatefulWidget {
  const RightPane({super.key, required this.projectsDirectory});

  final String projectsDirectory;

  @override
  ConsumerState<RightPane> createState() => _RightPaneState();
}

class _RightPaneState extends ConsumerState<RightPane> {
  final List<ProjectInfo> projectInfoList = [];

  Stream<List<ProjectInfo>> _getProjectData() async* {
    Directory projectsDirectory = Directory(widget.projectsDirectory);
    var watch = projectsDirectory.watch();

    List<ProjectInfo> initialData = [];

    List<FileSystemEntity> projects = projectsDirectory.listSync();
    for (var project in projects) {
      if (project is Directory) {
        FileStat stats = File(project.path).statSync();
        initialData.add(ProjectInfo(path.basename(project.path), stats.changed, stats.modified));
      }
    }

    yield initialData;

    await for (var event in watch) {
      if (event is Directory) {
        FileStat projectStats = File(event.path).statSync();
        yield [
          ...initialData,
          ProjectInfo(
            path.basename(event.path),
            projectStats.changed,
            projectStats.modified,
          ),
        ];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final layoutReader = ref.watch(app_providers.showProjectLayout.notifier);
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Center(
      child: StreamBuilder<List<ProjectInfo>>(
        stream: _getProjectData(),
        builder: (BuildContext context, AsyncSnapshot<List<ProjectInfo>> snapshot) {
          if (snapshot.hasData) {
            List<ProjectInfo> projectInfo = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: 200,
                  childAspectRatio: (1 / 1.4)),
              itemCount: projectInfo.length,
              itemBuilder: (context, index) {
                return ItemProject(projectInfo: projectInfo[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Text(
              "Error",
              style: TextStyle(color: theme.firstText),
            );
          } else {
            return Text(
              "Nothing",
              style: TextStyle(color: theme.firstText),
            );
          }
        },
      ),
    );
  }
}

class ItemProject extends ConsumerWidget {
  const ItemProject({super.key, required this.projectInfo});

  final ProjectInfo projectInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return CustomContainer(
      bodyColour: theme.fourthBackground,
      borderColour: theme.fourthOutline,
      borderRadius: app_constants.borderRadiusM,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logos/logo_placeholder_gray.png",
                    height: 64,
                    width: 64,
                  ),
                  const Gap(12),
                  AutoSizeText(
                    projectInfo.projectName,
                    style: TextStyle(color: theme.firstText, fontWeight: FontWeight.bold),
                    minFontSize: 18,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Text(
            DateFormat('MMM dd, yyyy').format(projectInfo.projectLastModifiedDate),
            style: TextStyle(color: theme.thirdText, fontWeight: FontWeight.normal),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const Gap(5),
          GestureDetector(
            onTap: () {
              showStandardDialog(
                context,
                ref,
                const DialogWaiting(
                  "Opening",
                  "Please wait as your project is getting loaded.",
                ),
              );

              Future.delayed(const Duration(seconds: 5), () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              });
            },
            child: ButtonOpenProject(),
          ),
        ],
      ),
    );
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
    final childDirectories = parentDirectory.watch();

    /*for (var entity in childDirectories) {
      if (entity is Directory) {
        folderNames.add(entity.path);
      }
    }*/
  } catch (e) {
    folderNames.add(e.toString());
  }

  return folderNames;
}

class ProjectInfo {
  final String projectName;
  final DateTime projectCreationDate;
  final DateTime projectLastModifiedDate;

  ProjectInfo(this.projectName, this.projectCreationDate, this.projectLastModifiedDate);
}
