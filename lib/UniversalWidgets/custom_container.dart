import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomContainer extends ConsumerWidget {
  const CustomContainer({
    Key? key,
    this.height,
    this.width,
    this.constraints,
    this.alignment,
    this.borderWidth,
    this.borderRadius,
    this.borderRadiusCustom,
    this.borderRadiusSubtraction = 0.0,
    this.borderRadiusSubtractionCustom = const [0.0, 0.0, 0.0, 0.0],
    this.bodyColour = Colors.transparent,
    this.borderColour = Colors.transparent,
    this.child,
  })  : assert(borderRadius != null || borderRadiusCustom != null),
        super(key: key);

  //General
  final double? height;
  final double? width;
  final BoxConstraints? constraints;
  final Alignment? alignment;

  //Border
  final double? borderWidth;
  final double? borderRadius;
  final List<double>? borderRadiusCustom;
  final double borderRadiusSubtraction;
  final List<double> borderRadiusSubtractionCustom;

  //Colour
  final Color bodyColour;
  final Color borderColour;

  //Children
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: borderRadius != null
          ? BorderRadius.circular(
              borderRadius! - borderRadiusSubtraction,
            )
          : BorderRadius.only(
              topLeft: Radius.circular(
                borderRadiusCustom![0] - borderRadiusSubtractionCustom[0],
              ),
              topRight: Radius.circular(
                borderRadiusCustom![1] - borderRadiusSubtractionCustom[1],
              ),
              bottomLeft: Radius.circular(
                borderRadiusCustom![2] - borderRadiusSubtractionCustom[2],
              ),
              bottomRight: Radius.circular(
                borderRadiusCustom![3] - borderRadiusSubtractionCustom[3],
              ),
            ),
      child: ChildBuilder(
        height: height,
        width: width,
        constraints: constraints,
        alignment: alignment,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        borderRadiusCustom: borderRadiusCustom,
        borderRadiusSubtraction: borderRadiusSubtraction,
        borderRadiusSubtractionCustom: borderRadiusSubtractionCustom,
        bodyColour: bodyColour,
        borderColour: borderColour,
        child: child,
      ),
    );
  }
}

class ChildBuilder extends ConsumerWidget {
  const ChildBuilder({
    Key? key,
    this.height,
    this.width,
    this.constraints,
    this.alignment,
    this.borderWidth,
    this.borderRadius,
    this.borderRadiusCustom,
    required this.borderRadiusSubtraction,
    required this.borderRadiusSubtractionCustom,
    required this.bodyColour,
    required this.borderColour,
    this.child,
  }) : super(key: key);

  //General
  final double? height;
  final double? width;
  final BoxConstraints? constraints;
  final Alignment? alignment;

  //Border
  final double? borderWidth;
  final double? borderRadius;
  final List<double>? borderRadiusCustom;
  final double borderRadiusSubtraction;
  final List<double> borderRadiusSubtractionCustom;

  //Colour
  final Color bodyColour;
  final Color borderColour;

  //Child
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        color: bodyColour,
        border: borderWidth != null
            ? Border.all(color: borderColour, width: borderWidth!)
            : null,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(
                borderRadius! - borderRadiusSubtraction,
              )
            : BorderRadius.only(
                topLeft: Radius.circular(
                  borderRadiusCustom![0] - borderRadiusSubtractionCustom[0],
                ),
                topRight: Radius.circular(
                  borderRadiusCustom![1] - borderRadiusSubtractionCustom[1],
                ),
                bottomLeft: Radius.circular(
                  borderRadiusCustom![2] - borderRadiusSubtractionCustom[2],
                ),
                bottomRight: Radius.circular(
                  borderRadiusCustom![3] - borderRadiusSubtractionCustom[3],
                ),
              ),
      ),
      child: child,
    );
  }
}
