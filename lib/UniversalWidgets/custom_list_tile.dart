import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tales/UniversalWidgets/custom_animated_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

class CustomListTile extends ConsumerStatefulWidget {
  const CustomListTile({super.key, required this.title, this.isChild = false,});

  final String title;
  final bool isChild;

  @override
  ConsumerState<CustomListTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends ConsumerState<CustomListTile>
    with TickerProviderStateMixin {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final disableAnimationsWatcher = ref.watch(app_providers.settingDisableAnimationsProvider);
    final themeWatcher = ref.watch(app_providers.settingDarkThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);

    return Listener(
      onPointerDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onPointerUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onPointerCancel: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovering = false;
          });
        },
        child: GestureDetector(
          onTap: () {

          },
          child: AnimatedCustomContainer(
            height: 30,
            bodyColour: _isPressed
                ? theme.firstText.withOpacity(0.05)
                : _isHovering
                ? theme.firstText.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: app_constants.borderRadiusS,
            duration: const Duration(milliseconds: 150),
            child: Row(
              children: [
                if (widget.isChild) const Gap(20),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        color: theme.firstText,
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.title,
                  style: TextStyle(color: theme.firstText, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
