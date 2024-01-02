import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import 'custom_animated_container.dart';

class CustomButtonListTile extends ConsumerWidget {
  const CustomButtonListTile({
    Key? key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.buttonFunction,
    this.disabled = false,
  }) : super(key: key);

  final String title;
  final String message;
  final String buttonText;
  final Function buttonFunction;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: AbsorbPointer(
        absorbing: disabled,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title ${disabled ? "[DISABLED]" : ""}",
                    style: TextStyle(
                      color: theme.secondText,
                      fontSize: 16,
                      height: 1.2,
                      fontFamily: "Rounded",
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: TextStyle(
                      color: theme.thirdText,
                      fontSize: 12,
                      height: 1.2,
                      fontFamily: "Rounded",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                ///Run Function
                buttonFunction();
              },
              child: AnimatedCustomContainer(
                height: 35,
                bodyColour: theme.thirdBackground,
                borderRadius: app_constants.borderRadiusM,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: theme.firstText,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
