import 'package:flutter/material.dart';

import 'colors.dart';

extension ThemeProvider on BuildContext{
  //usage context.theme
  ThemeData get theme => Theme.of(this);
}

extension AppThemeExtension on ThemeData {
  //usage Theme.of(context).colors
  AppColors get colors => extension<AppColors>()
      ?? const AppColors(); // fallback to default if not provided
}

extension X on TextStyle? {
  TextStyle? withColor(Color? color) => this?.copyWith(color: color);
}