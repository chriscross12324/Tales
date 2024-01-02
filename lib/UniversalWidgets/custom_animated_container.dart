import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tales/app_providers.dart' as app_providers;

class AnimatedCustomContainer extends ConsumerWidget {
  const AnimatedCustomContainer({
    Key? key,
    this.height,
    this.width,
    this.constraints,
    this.alignment,
    this.borderWidth = 0.0,
    this.borderRadius,
    this.borderRadiusCustom,
    this.borderRadiusSubtraction = 0.0,
    this.borderRadiusSubtractionCustom,
    this.bodyColour = Colors.transparent,
    this.borderColour = Colors.transparent,
    this.duration = const Duration(milliseconds: 500),
    this.curve,
    this.child,
  })  : assert(
            (borderRadius != null && borderRadiusSubtraction != null) ||
                (borderRadiusCustom != null &&
                    borderRadiusSubtractionCustom != null),
            "[INVALID CONFIG]\n"
            "- borderRadius & borderRadiusSubtraction must be non-null\n"
            "OR\n"
            "- borderRadiusCustom & borderRadiusSubtractionCustom must be non-null"
            "WHERE borderRadius & borderRadiusSubtraction will take precedence."),
        super(key: key);

  final double? height;
  final double? width;
  final BoxConstraints? constraints;
  final Alignment? alignment;

  final double borderWidth;

  final double? borderRadius;
  final List<double>? borderRadiusCustom;
  final double? borderRadiusSubtraction;
  final List<double>? borderRadiusSubtractionCustom;

  final Color bodyColour;
  final Color borderColour;

  final Duration duration;
  final Curve? curve;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disableAnimationsWatcher = ref.watch(app_providers.settingDisableAnimationsProvider);

    return AnimatedContainer(
        height: height,
        width: width,
        constraints: constraints,
        alignment: alignment,
        duration: disableAnimationsWatcher ? Duration.zero : duration,
        curve: curve ?? Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          color: bodyColour,
          border: Border.all(
            color: borderColour,
            width: borderWidth,
          ),
          borderRadius: borderRadius != null
              ? BorderRadius.all(
                  Radius.circular((borderRadius! - borderRadiusSubtraction!)),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(
                    (borderRadiusCustom![0] - borderRadiusSubtractionCustom![0]),
                  ),
                  topRight: Radius.circular(
                    (borderRadiusCustom![1] - borderRadiusSubtractionCustom![1]),
                  ),
                  bottomLeft: Radius.circular(
                    (borderRadiusCustom![2] - borderRadiusSubtractionCustom![2]),
                  ),
                  bottomRight: Radius.circular(
                    (borderRadiusCustom![3] - borderRadiusSubtractionCustom![3]),
                  ),
                ),
        ),
        child: child);
  }
}
