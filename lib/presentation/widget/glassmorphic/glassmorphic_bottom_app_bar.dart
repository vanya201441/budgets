import 'package:byte_budget/presentation/colors.dart';
import 'package:byte_budget/presentation/widget/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlassmorphicBottomAppBar extends StatefulWidget {
  const GlassmorphicBottomAppBar({
    required this.children,
    this.blur = 2,
    this.borderWidth = 2,
    this.bodyGradient,
    this.borderGradient,
    this.notchMargin = 4.0,
    this.shape,
    super.key,
  });

  final double blur;
  final double borderWidth;
  final Gradient? borderGradient;
  final Gradient? bodyGradient;
  final NotchedShape? shape;
  final double notchMargin;
  final List<Widget> children;

  @override
  State<GlassmorphicBottomAppBar> createState() =>
      _GlassmorphicBottomAppBarState();
}

class _GlassmorphicBottomAppBarState extends State<GlassmorphicBottomAppBar> {
  late ValueListenable<ScaffoldGeometry> geometryListenable;
  final GlobalKey materialKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasFab = Scaffold.of(context).hasFloatingActionButton;
    final NotchedShape? notchedShape = widget.shape;
    final CustomClipper<Path> clipper = notchedShape != null && hasFab
        ? _BottomAppBarClipper(
            geometry: geometryListenable,
            shape: notchedShape,
            materialKey: materialKey,
            notchMargin: widget.notchMargin,
          )
        : const ShapeBorderClipper(shape: RoundedRectangleBorder());

    final painter = _BottomAppBarPainter(
      strokeWidth: widget.borderWidth,
      gradient: widget.borderGradient ?? AppColors.kBorderGradientFill,
      geometry: geometryListenable,
      shape: notchedShape ?? const CircularNotchedRectangle(),
      materialKey: materialKey,
      notchMargin: widget.notchMargin,
    );

    final gradient = widget.bodyGradient ?? AppColors.greenGradient;

    return Glassmorphic(
      blur: 2,
      bodyGradient: gradient,
      borderStyle: GlassmorphicBorderStyle (
        strokeWidth: 2,
        clipper: clipper,
        customPainter: painter,
      ),
      child: BottomAppBar(
        padding: EdgeInsets.zero,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.children,
        ),
      ),
    );
  }
}

class _BottomAppBarClipper extends CustomClipper<Path> {
  const _BottomAppBarClipper({
    required this.geometry,
    required this.shape,
    required this.materialKey,
    required this.notchMargin,
  }) : super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final GlobalKey materialKey;
  final double notchMargin;

  // Returns the top of the BottomAppBar in global coordinates.
  //
  // If the Scaffold's bottomNavigationBar was specified, then we can use its
  // geometry value, otherwise we compute the location based on the AppBar's
  // Material widget.
  double get bottomNavigationBarTop {
    final double? bottomNavigationBarTop =
        geometry.value.bottomNavigationBarTop;
    if (bottomNavigationBarTop != null) {
      return bottomNavigationBarTop;
    }
    final RenderBox? box =
        materialKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy ?? 0;
  }

  @override
  Path getClip(Size size) {
    // button is the floating action button's bounding rectangle in the
    // coordinate system whose origin is at the appBar's top left corner,
    // or null if there is no floating action button.
    final Rect? button = geometry.value.floatingActionButtonArea
        ?.translate(0.0, bottomNavigationBarTop * -1.0);
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_BottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}

class _BottomAppBarPainter extends CustomPainter {
  const _BottomAppBarPainter({
    required this.strokeWidth,
    required this.gradient,
    required this.geometry,
    required this.shape,
    required this.notchMargin,
    required this.materialKey,
  });

  final double strokeWidth;
  final Gradient gradient;
  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;
  final GlobalKey materialKey;

  double get bottomNavigationBarTop {
    final double? bottomNavigationBarTop =
        geometry.value.bottomNavigationBarTop;
    if (bottomNavigationBarTop != null) {
      return bottomNavigationBarTop;
    }
    final RenderBox? box =
        materialKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy ?? 0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Rect? button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      bottomNavigationBarTop * -1.0,
    );

    final path = shape.getOuterPath(
      Offset.zero & size,
      button?.inflate(notchMargin),
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _BottomAppBarPainter) {
      return oldDelegate == this;
    }

    return false;
  }
}
