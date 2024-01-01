import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tales/app_constants.dart' as app_constants;

class CustomSingleChildScrollView extends ConsumerWidget {
  const CustomSingleChildScrollView({
    super.key,
    this.borderRadius = app_constants.borderRadiusS,
    this.scrollDirection = Axis.vertical,
    required this.children,
  });

  final double borderRadius;
  final Axis scrollDirection;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SingleChildScrollView(
        child: scrollDirection == Axis.vertical
            ? Column(children: children)
            : Row(children: children),
      ),
    );
  }
}
