import 'dart:ui';

import 'package:byte_budget/presentation/colors.dart';
import 'package:byte_budget/presentation/widget/widgets.dart';
import 'package:flutter/material.dart';

class Glassmorphic extends StatelessWidget {
  const Glassmorphic({
    required this.blur,
    required this.child,
    this.borderRadius = 8,
    this.borderStyle,
    this.glassColor,
    this.isFrosted,
    this.frostedOpacity = AppColors.kFrostedOpacity,
    this.bodyGradient,
    this.transform,
    this.margin,
    this.padding,
    this.constraints,
    this.alignment,
    this.width,
    this.height,
    super.key,
  }) : assert(frostedOpacity >= 0 && frostedOpacity <= 1),
       assert(glassColor == null || bodyGradient == null);

  final double borderRadius;
  final GlassmorphicBorderStyle? borderStyle;

  final double blur;
  final bool? isFrosted;
  final double frostedOpacity;
  final Color? glassColor;
  final Gradient? bodyGradient;

  final double? width;
  final double? height;
  final Matrix4? transform;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      transform: transform,
      child: GlassmorphicBorder(
        style: borderStyle?.copyWith(radius: borderRadius) ?? GlassmorphicBorderStyle(radius: borderRadius),
        child: Container(
          width: width,
          height: height,
          alignment: alignment,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: (isFrosted == true)
                ? DecorationImage(
                    image: const AssetImage('assets/images/noise.png'),
                    fit: BoxFit.cover,
                    opacity: frostedOpacity,
                    colorFilter: ColorFilter.mode(
                      AppColors.kFrostBlendColor,
                      AppColors.kFrostBlendMode,
                    ),
                  )
                : null,
            gradient: bodyGradient,
            color: glassColor,
          ),
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur * 2),
              child: ColoredBox(
                color: glassColor ?? Colors.transparent,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
