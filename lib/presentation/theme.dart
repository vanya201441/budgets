import 'package:byte_budget/presentation/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryDark),
    useMaterial3: true,
  );
}