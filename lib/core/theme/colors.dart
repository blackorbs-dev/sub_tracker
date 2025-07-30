import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  // Root Theme
  final Color background;
  final Color foreground;
  final Color card;
  final Color primary;
  final Color primaryGlow;
  final Color secondary;
  final Color mutedForeground;
  final Color destructive;
  final Color success;
  final Color warning;
  final Color info;

  // Sidebar
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarAccent;
  final Color sidebarBorder;
  final Color sidebarRing;

  // Dark Theme
  final Color darkBackground;
  final Color darkForeground;
  final Color darkPrimaryForeground;
  final Color darkSecondary;
  final Color darkMutedForeground;
  final Color darkDestructive;
  final Color darkRing;
  final Color darkSidebarForeground;

  const AppColors({
    // Root
    this.background = const Color(0xFFfafafa),
    this.foreground = const Color(0xFF0a0a0b),
    this.card = const Color(0xFF0a0a0b),
    this.primary = const Color(0xFF8b5cf6),
    this.primaryGlow = const Color(0xFFa78bfa),
    this.secondary = const Color(0xFF27272a),
    this.mutedForeground = const Color(0xFFa1a1aa),
    this.destructive = const Color(0xFFef4444),
    this.success = const Color(0xFF16a34a),
    this.warning = const Color(0xFFf59e0b),
    this.info = const Color(0xFF0ea5e9),

    // Sidebar
    this.sidebarForeground = const Color(0xFF404040),
    this.sidebarPrimary = const Color(0xFF171717),
    this.sidebarAccent = const Color(0xFFf4f4f5),
    this.sidebarBorder = const Color(0xFFe4e4e7),
    this.sidebarRing = const Color(0xFF3b82f6),

    // Dark Theme
    this.darkBackground = const Color(0xFF020617),
    this.darkForeground = const Color(0xFFf8fafc),
    this.darkPrimaryForeground = const Color(0xFF0f172a),
    this.darkSecondary = const Color(0xFF1e293b),
    this.darkMutedForeground = const Color(0xFF94a3b8),
    this.darkDestructive = const Color(0xFF7f1d1d),
    this.darkRing = const Color(0xFFcbd5e1),
    this.darkSidebarForeground = const Color(0xFFf1f5f9),
  });

  @override
  AppColors copyWith({
    Color? background,
    Color? foreground,
    Color? card,
    Color? cardForeground,
    Color? primary,
    Color? primaryForeground,
    Color? primaryGlow,
    Color? secondary,
    Color? secondaryForeground,
    Color? muted,
    Color? mutedForeground,
    Color? accent,
    Color? destructive,
    Color? success,
    Color? warning,
    Color? info,
    Color? border,
    Color? ring,

    Color? sidebarBackground,
    Color? sidebarForeground,
    Color? sidebarPrimary,
    Color? sidebarAccent,
    Color? sidebarBorder,
    Color? sidebarRing,

    Color? darkBackground,
    Color? darkForeground,
    Color? darkPrimary,
    Color? darkPrimaryForeground,
    Color? darkSecondary,
    Color? darkMutedForeground,
    Color? darkDestructive,
    Color? darkRing,
    Color? darkSidebarBackground,
    Color? darkSidebarForeground,
    Color? darkSidebarPrimary,
  }) {
    return AppColors(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      card: card ?? this.card,
      primary: primary ?? this.primary,
      primaryGlow: primaryGlow ?? this.primaryGlow,
      secondary: secondary ?? this.secondary,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      destructive: destructive ?? this.destructive,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,

      sidebarForeground: sidebarForeground ?? this.sidebarForeground,
      sidebarPrimary: sidebarPrimary ?? this.sidebarPrimary,
      sidebarAccent: sidebarAccent ?? this.sidebarAccent,
      sidebarBorder: sidebarBorder ?? this.sidebarBorder,
      sidebarRing: sidebarRing ?? this.sidebarRing,

      darkBackground: darkBackground ?? this.darkBackground,
      darkForeground: darkForeground ?? this.darkForeground,
      darkPrimaryForeground: darkPrimaryForeground ?? this.darkPrimaryForeground,
      darkSecondary: darkSecondary ?? this.darkSecondary,
      darkMutedForeground: darkMutedForeground ?? this.darkMutedForeground,
      darkDestructive: darkDestructive ?? this.darkDestructive,
      darkRing: darkRing ?? this.darkRing,
      darkSidebarForeground: darkSidebarForeground ?? this.darkSidebarForeground,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      card: Color.lerp(card, other.card, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryGlow: Color.lerp(primaryGlow, other.primaryGlow, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,

      sidebarForeground: Color.lerp(sidebarForeground, other.sidebarForeground, t)!,
      sidebarPrimary: Color.lerp(sidebarPrimary, other.sidebarPrimary, t)!,
      sidebarAccent: Color.lerp(sidebarAccent, other.sidebarAccent, t)!,
      sidebarBorder: Color.lerp(sidebarBorder, other.sidebarBorder, t)!,
      sidebarRing: Color.lerp(sidebarRing, other.sidebarRing, t)!,

      darkBackground: Color.lerp(darkBackground, other.darkBackground, t)!,
      darkForeground: Color.lerp(darkForeground, other.darkForeground, t)!,
      darkPrimaryForeground: Color.lerp(darkPrimaryForeground, other.darkPrimaryForeground, t)!,
      darkSecondary: Color.lerp(darkSecondary, other.darkSecondary, t)!,
      darkMutedForeground: Color.lerp(darkMutedForeground, other.darkMutedForeground, t)!,
      darkDestructive: Color.lerp(darkDestructive, other.darkDestructive, t)!,
      darkRing: Color.lerp(darkRing, other.darkRing, t)!,
      darkSidebarForeground: Color.lerp(darkSidebarForeground, other.darkSidebarForeground, t)!,
    );
  }
}
