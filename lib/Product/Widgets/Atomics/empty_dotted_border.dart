// Dotter Border Widget
import 'package:dotted_border/dotted_border.dart';
import 'package:ekin_app/Core/Constants/radius.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../Core/Constants/padding_const.dart';

class EmptyDotterBorder extends StatelessWidget {
  const EmptyDotterBorder(
      {super.key, required this.child, required this.height, this.onTap});
  final Widget child;
  final double height;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      borderRadius: AppRadius.radius15Circular,
      containedInkWell: true,
      highlightShape: BoxShape.rectangle,
      child: DottedBorder(
          strokeCap: StrokeCap.round,
          radius: const Radius.circular(15),
          dashPattern: const [10, 15],
          color: context.colorScheme.inversePrimary,
          borderType: BorderType.RRect,
          strokeWidth: 5,
          child: Container(
              width: double.infinity,
              height: context.dynamicHeight(height),
              margin: kPaddingVerticalMedium + kPaddingHorizontalMed,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: context.colorScheme.inversePrimary,
                borderRadius: AppRadius.radius12Circular,
              ),
              child: child)),
    );
  }
}
