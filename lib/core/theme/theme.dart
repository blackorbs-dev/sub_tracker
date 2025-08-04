import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppPalette.sidebarBorder,
  extensions: const [ AppColors() ],
  textTheme: textTheme,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppPalette.darkPrimaryForeground,
  extensions: const [
    AppColors(
      background: AppPalette.darkPrimaryForeground,
      foreground: AppPalette.darkMutedForeground,
      sidebarAccent: AppPalette.darkRing,
      sidebarBorder: AppPalette.darkRing,
      darkRing: AppPalette.darkPrimaryForeground
    ),
  ],
  textTheme: textTheme,
);
