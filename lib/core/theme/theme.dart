import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  extensions: const <ThemeExtension<dynamic>>[
    AppColors(),
  ],
  textTheme: textTheme,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  extensions: const <ThemeExtension<dynamic>>[
    AppColors(
      // Override only dark values
      background: Color(0xFF020617),
      foreground: Color(0xFFf8fafc),
      primary: Color(0xFFf8fafc),
      secondary: Color(0xFF1e293b),
      mutedForeground: Color(0xFF94a3b8),
      destructive: Color(0xFF7f1d1d),
      sidebarForeground: Color(0xFFf1f5f9),
      sidebarPrimary: Color(0xFF3b82f6),
    ),
  ],
);
