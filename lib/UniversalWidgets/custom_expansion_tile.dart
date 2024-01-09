import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tales/UniversalWidgets/custom_animated_container.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

class CustomExpansionTile extends ConsumerStatefulWidget {
  const CustomExpansionTile({super.key, required this.title});

  final String title;

  @override
  ConsumerState<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends ConsumerState<CustomExpansionTile> {
  bool _isExpanded = false;
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
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
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: AnimatedCustomContainer(
            height: 30,
            bodyColour: _isPressed
                ? theme.firstText.withOpacity(0.15)
                : _isHovering
                    ? theme.firstText.withOpacity(0.05)
                    : Colors.transparent,
            borderRadius: app_constants.borderRadiusS,
            duration: const Duration(milliseconds: 150),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: AnimatedRotation(
                    turns: _isExpanded ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.fastOutSlowIn,
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: SvgPicture.asset('assets/icons/icon_arrow_right.svg', colorFilter: ColorFilter.mode(theme.firstText, BlendMode.srcIn),),
                    ),
                  ),
                ),
                Text(
                  '${widget.title} - $_isExpanded',
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
