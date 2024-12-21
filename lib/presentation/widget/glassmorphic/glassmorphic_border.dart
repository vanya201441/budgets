import 'package:byte_budget/presentation/colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum GlassmorphicShape {
  circle,
  rectangle,
}

class GlassmorphicBorder extends StatelessWidget {
  const GlassmorphicBorder({
    this.child,
    this.style,
    super.key,
  });

  final GlassmorphicBorderStyle? style;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? const GlassmorphicBorderStyle();

    final painter = style.customPainter ??
        switch (style.boxShape) {
          GlassmorphicShape.rectangle => _RRectBorderPainter(
              strokeWidth: style.strokeWidth,
              radius: style.radius,
              gradient: style.gradient,
            ),
          GlassmorphicShape.circle => _CircleBorderPainter(
              strokeWidth: style.strokeWidth,
              gradient: style.gradient,
            ),
        };

    final clipper = style.clipper ??
        ShapeBorderClipper(
          shape: switch (style.boxShape) {
            GlassmorphicShape.rectangle => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(style.radius),
              ),
            GlassmorphicShape.circle => const CircleBorder(),
          },
        );

    return CustomPaint(
      painter: painter,
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}

class GlassmorphicBorderStyle extends Equatable {
  const GlassmorphicBorderStyle({
    this.strokeWidth = 2,
    this.radius = 8,
    this.boxShape = GlassmorphicShape.rectangle,
    this.gradient = AppColors.kBorderGradientFill,
    this.customPainter,
    this.clipper,
  })  : assert(strokeWidth >= 0),
        assert(radius >= 0);

  final double radius;
  final double strokeWidth;
  final Gradient gradient;
  final CustomPainter? customPainter;
  final CustomClipper<Path>? clipper;
  final GlassmorphicShape boxShape;

  GlassmorphicBorderStyle copyWith({
    double? strokeWidth,
    double? radius,
    Gradient? gradient,
    CustomPainter? customPainter,
    CustomClipper<Path>? clipper,
    GlassmorphicShape? boxShape,
  }) {
    return GlassmorphicBorderStyle(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      radius: radius ?? this.radius,
      gradient: gradient ?? this.gradient,
      customPainter: customPainter ?? this.customPainter,
      clipper: clipper ?? this.clipper,
      boxShape: boxShape ?? this.boxShape,
    );
  }

  @override
  bool? get stringify => false;

  @override
  List<Object?> get props => [
        strokeWidth,
        radius,
        gradient,
      ];
}

class _RRectBorderPainter extends CustomPainter implements EquatableMixin {
  _RRectBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  final Paint paintObject = Paint();
  final Paint paintObject2 = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final borderSize = Size(
      size.width + strokeWidth * 2,
      size.height + strokeWidth * 2,
    );

    RRect outerRect = RRect.fromRectAndRadius(
      Offset(-strokeWidth, -strokeWidth) & borderSize,
      Radius.circular(radius + strokeWidth),
    );

    RRect innerRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    paintObject.shader = gradient.createShader(Offset.zero & borderSize);

    Path outerRectPath = Path()..addRRect(outerRect);
    Path innerRectPath = Path()..addRRect(innerRect);
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          outerRectPath,
          Path.combine(
            PathOperation.intersect,
            outerRectPath,
            innerRectPath,
          ),
        ),
        paintObject);
  }

  @override
  bool? get stringify => false;

  @override
  List<Object?> get props => [
        strokeWidth,
        radius,
        gradient,
      ];

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _RRectBorderPainter) {
      return oldDelegate == this;
    }
    return false;
  }
}

class _CircleBorderPainter extends CustomPainter implements EquatableMixin {
  const _CircleBorderPainter({
    required this.strokeWidth,
    required this.gradient,
  });

  final double strokeWidth;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = size.width / 2;

    // Создание градиентного шейдера
    final gradientShader = gradient.createShader(rect);

    // Кисть для рисования обводки
    final paint = Paint()
      ..shader = gradientShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Рисование круга
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2), // Центр
      radius + strokeWidth / 2, // Радиус с учётом ширины обводки
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _CircleBorderPainter) {
      return oldDelegate == this;
    }
    return false;
  }

  @override
  bool? get stringify => false;

  @override
  List<Object?> get props => [
        strokeWidth,
        gradient,
      ];
}
