import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tales/app_providers.dart' as app_providers;
import 'package:tales/app_themes.dart' as app_themes;
import 'package:tales/app_constants.dart' as app_constants;

import 'custom_container.dart';

class ResizablePane extends ConsumerStatefulWidget {
  const ResizablePane(
      {super.key, required this.leftWidget, required this.rightWidget});

  final Widget leftWidget;
  final Widget rightWidget;

  @override
  ConsumerState<ResizablePane> createState() => _ResizablePaneState();
}

class _ResizablePaneState extends ConsumerState<ResizablePane> {
  double leftPaneWidth = 200.0;
  double minPaneWidth = 200.0;
  double maxPaneWidth = 400.0;

  bool mouseHoveringDivider = false;
  bool isResizing = false;

  @override
  Widget build(BuildContext context) {
    final themeWatcher = ref.watch(app_providers.settingThemeProvider);
    final theme = app_themes.theme(themeWatcher, ref);
    //maxPaneWidth = MediaQuery.of(context).size.width / 2;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        maxPaneWidth = (constraints.maxWidth / 2) - 75;

        if (leftPaneWidth > maxPaneWidth) {
          leftPaneWidth = maxPaneWidth;
        }

        return Row(
          children: [
            SizedBox(
              width: leftPaneWidth,
              child: widget.leftWidget,
            ),
            GestureDetector(
              onHorizontalDragUpdate: (dragUpdateDetails) {
                setState(() {
                  leftPaneWidth += dragUpdateDetails.primaryDelta!;
                  if (leftPaneWidth < minPaneWidth) {
                    leftPaneWidth = minPaneWidth;
                  } else if (leftPaneWidth > maxPaneWidth) {
                    leftPaneWidth = maxPaneWidth;
                  }
                });
              },
              child: Listener(
                onPointerUp: (_) {
                  setState(() {
                    isResizing = false;
                  });
                },
                onPointerDown: (_) {
                  setState(() {
                    isResizing = true;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  onEnter: (_) {
                    setState(() {
                      mouseHoveringDivider = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      mouseHoveringDivider = false;
                    });
                  },
                  child: Container(
                    width: app_constants.modulePadding,
                    color: Colors.transparent,
                    child: Center(
                      child: AnimatedContainer(
                        height: isResizing || mouseHoveringDivider ? 100 : 40,
                        width: isResizing || mouseHoveringDivider ? 3 : 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: isResizing ? theme.thirdText : theme.fourthText,
                        ),
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: widget.rightWidget),
          ],
        );
      },
    );
  }
}
