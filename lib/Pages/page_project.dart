import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tales/Dialogs/dialog_confirm.dart';
import 'package:tales/Pages/page_starting.dart';
import 'package:tales/UniversalWidgets/custom_buttons.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';
import 'package:tales/UniversalWidgets/custom_expansion_tile.dart';
import 'package:tales/UniversalWidgets/resizable_pane.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;
import 'package:watcher/watcher.dart';

import '../Dialogs/system_dialog.dart';

class PageProject extends ConsumerWidget {
  const PageProject({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingDarkThemeProvider);
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
            child: ResizablePane(
              leftWidget: const NavigationPane(),
              rightWidget: CustomContainer(
                height: double.infinity,
                bodyColour: theme.secondBackground,
                borderRadiusCustom: const [
                  app_constants.borderRadiusM,
                  app_constants.borderRadiusM,
                  app_constants.borderRadiusM,
                  app_constants.borderRadiusS,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NavigationPane extends ConsumerWidget {
  const NavigationPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProjectWatcher = ref.watch(app_providers.currentProjectProvider);
    final themeWatcher = ref.watch(app_providers.settingDarkThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return CustomContainer(
      height: double.infinity,
      bodyColour: theme.secondBackground,
      borderRadiusCustom: const [
        app_constants.borderRadiusM,
        app_constants.borderRadiusM,
        app_constants.borderRadiusS,
        app_constants.borderRadiusM,
      ],
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            CustomContainer(
              height: 30,
              bodyColour: theme.thirdBackground,
              borderRadius: app_constants.borderRadiusS,
              child: Stack(
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Tales - ",
                            style: TextStyle(
                              color: theme.thirdText,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: path.basename(currentProjectWatcher),
                            style: TextStyle(
                              color: theme.firstText,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        ///Close Project
                        showStandardDialog(
                          context,
                          ref,
                          DialogConfirm(
                            "Exit Project",
                            "You are about to close the project. Are you sure you want to continue?",
                            "Back",
                            () {
                              ref
                                  .watch(app_providers.currentProjectProvider.notifier)
                                  .updateState("");
                            },
                            () {},
                          ),
                        );
                      },
                      child: ButtonIcon(
                        buttonIcon: 'assets/icons/icon_close.svg',
                        buttonSize: 30,
                        iconPadding: 8,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(5),
            Expanded(
              child: FolderList(projectPath: currentProjectWatcher),
            ),
            const Gap(app_constants.modulePadding),
            const SettingsHelp(),
          ],
        ),
      ),
    );
  }
}

class FolderList extends ConsumerStatefulWidget {
  const FolderList({super.key, required this.projectPath});

  final String projectPath;

  @override
  ConsumerState<FolderList> createState() => _FolderListState();
}

class _FolderListState extends ConsumerState<FolderList> {
  late Directory projectDirectory;
  late StreamController<void> _controller;

  @override
  void initState() {
    super.initState();
    projectDirectory = Directory(widget.projectPath);
    _controller = StreamController<void>();
    _startWatching();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _startWatching() {
    final watcher = DirectoryWatcher(projectDirectory.path);
    watcher.events.listen((event) {
      setState(() {
        _controller.add(null);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        List<Widget> folderWidgets = [];

        projectDirectory.listSync().forEach((folder) {
          if (folder is Directory) {
            List<Widget> fileWidgets = [];

            folder.listSync().forEach((file) {
              if (file is File) {
                fileWidgets.add(
                  ListTile(
                    title: Text(
                      path.basename(file.path).replaceAll(RegExp(r'\..*'), ''),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            });

            folderWidgets.add(
              CustomExpansionTile(title: path.basename(folder.path),)
              /*ExpansionTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  path.basename(folder.path),
                  style: TextStyle(color: Colors.white),
                ),
                children: fileWidgets,
              ),*/
            );
          }
        });

        return ListView(
          children: folderWidgets,
        );
      },
    );
  }
}
