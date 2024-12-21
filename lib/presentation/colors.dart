import 'package:flutter/material.dart';

abstract class AppColors {
  // 4CAF50
  static final primary = Colors.green[500]!;
  static final primaryDark = Colors.green[800]!;
  static final primaryLight = Colors.green[300]!;

  static final primaryTransparent = Colors.white24.withOpacity(0.4);

  static final greenGradient = LinearGradient(
    begin: Alignment.topCenter,
    tileMode: TileMode.mirror,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.primaryLight.withOpacity(0.4),
      AppColors.primaryDark.withOpacity(0.4),
      AppColors.primaryDark.withOpacity(0.8),
    ],
    stops: const [0, 0.9, 1],
  );

  static final greenGradient60 = LinearGradient(
    begin: Alignment.topCenter,
    tileMode: TileMode.mirror,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.primaryLight.withOpacity(0.5),
      AppColors.primaryDark.withOpacity(0.5),
    ],
    stops: const [0, 1],
  );

  static final redGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFFFF8E8E).withOpacity(0.4),
      const Color(0xFFFF3B3B).withOpacity(0.4),
      const Color(0xFFFF2727).withOpacity(0.8),
    ],
    stops: const [0, 0.9, 1],
  );

  static final whiteRadialGradient = RadialGradient(
    // begin: Alignment.topLeft,
    // end: Alignment.bottomRight,
    colors: [
      Colors.white54.withOpacity(0.4),
      Colors.black87.withOpacity(0.4),
      Colors.white54.withOpacity(0.4),
    ],
  );

  static final greyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.grey[700]!.withOpacity(0.5),
      Colors.grey[700]!.withOpacity(0.5),
    ],
  );

  static final borderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white54.withOpacity(0.4),
      Colors.black87.withOpacity(0.4),
      // Colors.grey[300]!.withOpacity(0.5),
      // Colors.grey[700]!.withOpacity(0.5),
    ],
  );

  static const double kFrostedOpacity = 0.10;

  static final Color kFrostBlendColor =
      Colors.white.withOpacity(0.5); //Color(0xFFFFFFFF);

  static const BlendMode kFrostBlendMode = BlendMode.difference;

  static const LinearGradient kGradientFill = LinearGradient(
    colors: [Color(0x66FFFFFF), Color(0x1AFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment(0.80, 0.80),
  );

  static const LinearGradient kBorderGradientFill = LinearGradient(
    colors: [
      Color(0x99FFFFFF),
      Color(0x1AFFFFFF),
      Color(0x1AF0FFFF),
      Color(0x99F0FFFF)
    ],
    begin: Alignment(0.2, 0.0),
    end: Alignment(1.0, 1.0),
    stops: [0.0, 0.39, 0.40, 1.0],
  );
}
