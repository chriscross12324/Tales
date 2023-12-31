import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tales/Dialogs/dialog_action.dart';
import 'package:tales/Dialogs/system_dialog.dart';
import 'package:tales/UniversalWidgets/custom_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

class PageStarting extends ConsumerWidget {
  const PageStarting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final themeReader = ref.watch(app_providers.settingThemeProvider.notifier);
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
                    child: SingleChildScrollView(
                      child: Column(
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
                            onTap: () async {
                              String? selectedDirectory =
                                  await FilePicker.platform.getDirectoryPath();
                              if (selectedDirectory == null) {
                                showDialog(
                                  context: context,
                                  builder: (cntx) {
                                    return AlertDialog(
                                      title: Text("Selection Cancelled"),
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (cntx) {
                                    return AlertDialog(
                                      title: Text(selectedDirectory),
                                    );
                                  },
                                );
                              }
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
                          CustomContainer(
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
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(app_constants.modulePadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        themeReader.updateState(!themeWatcher);
                      },
                      child: CustomContainer(
                        height: 40,
                        width: 40,
                        bodyColour: Colors.transparent,
                        borderRadius: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            "assets/icons/icon_settings.svg",
                            color: theme.secondText,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showStandardDialog(
                          context,
                          ref,
                          DialogAction(
                            "Test Dialog",
                            "This is a test dialog, nothing will happen.",
                            "Primary",
                            "Secondary",
                            () {},
                            () {},
                          ),
                        );
                      },
                      child: CustomContainer(
                        height: 40,
                        width: 40,
                        bodyColour: Colors.transparent,
                        borderRadius: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            "assets/icons/icon_help.svg",
                            color: theme.secondText,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
