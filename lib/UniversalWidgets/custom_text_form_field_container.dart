import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import 'custom_container.dart';

class CustomTextFormField extends ConsumerWidget {
  const CustomTextFormField({
    super.key,
    this.height = 40.0,
    this.width,
    this.constraints,
    this.alignment,
    this.borderWidth = 2.0,
    required this.borderRadius,
    this.borderRadiusSubtraction = 0.0,
    required this.bodyColour,
    required this.borderColour,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    required this.textInputAction,
    this.multipleLines = false,
    this.hintText = "",
  });

  ///Container Attributes
  //General
  final double? height;
  final double? width;
  final BoxConstraints? constraints;
  final Alignment? alignment;

  //Border
  final double? borderWidth;
  final double? borderRadius;
  final double borderRadiusSubtraction;

  //Colour
  final Color bodyColour;
  final Color borderColour;

  ///TextFormField Attributes
  //Input
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final bool multipleLines;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: CustomContainer(
        height: height,
        width: width,
        constraints: constraints,
        alignment: alignment,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        borderRadiusSubtraction: borderRadiusSubtraction,
        bodyColour: bodyColour,
        borderColour: borderColour,
        child: Center(
          child: TextField(
            controller: textEditingController,
            keyboardType: textInputType,
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            maxLines: multipleLines ? double.infinity.toInt() : 1,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: theme.thirdText,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            style: TextStyle(
              color: theme.firstText,
              fontSize: 15,
            ),
            cursorColor: theme.firstText,
            cursorWidth: 2,
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }
}