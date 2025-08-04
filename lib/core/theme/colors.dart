import 'package:flutter/material.dart';

abstract class AppPalette {
  // Root
  static const Color background = Color(0xFFfafafa);
  static const Color foreground = Color(0xFF0a0a0b);
  static const Color card = Color(0xFFffffff);
  static const Color primary = Color(0xFF8b5cf6);
  static const Color primaryGlow = Color(0xFFa78bfa);
  static const Color secondary = Color(0xFF27272a);
  static const Color mutedForeground = Color(0xFFa1a1aa);
  static const Color destructive = Color(0xFFef4444);
  static const Color success = Color(0xFF16a34a);
  static const Color warning = Color(0xFFf59e0b);
  static const Color info = Color(0xFF0ea5e9);

  // Sidebar
  static const Color sidebarForeground = Color(0xFF404040);
  static const Color sidebarPrimary = Color(0xFF171717);
  static const Color sidebarAccent = Color(0xFFf4f4f5);
  static const Color sidebarBorder = Color(0xFFe4e4e7);
  static const Color sidebarRing = Color(0xFF3b82f6);

  // Dark
  static const Color darkBackground = Color(0xFF020617);
  static const Color darkForeground = Color(0xFFf8fafc);
  static const Color darkPrimaryForeground = Color(0xFF0f172a);
  static const Color darkSecondary = Color(0xFF1e293b);
  static const Color darkMutedForeground = Color(0xFF94a3b8);
  static const Color darkDestructive = Color(0xFF7f1d1d);
  static const Color darkRing = Color(0xFFcbd5e1);
  static const Color darkSidebarForeground = Color(0xFFf1f5f9);
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
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

  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarAccent;
  final Color sidebarBorder;
  final Color sidebarRing;

  final Color darkBackground;
  final Color darkForeground;
  final Color darkPrimaryForeground;
  final Color darkSecondary;
  final Color darkMutedForeground;
  final Color darkDestructive;
  final Color darkRing;
  final Color darkSidebarForeground;

  const AppColors({
    this.background = AppPalette.sidebarBorder,
    this.foreground = AppPalette.darkPrimaryForeground,
    this.card = AppPalette.card,
    this.primary = AppPalette.primary,
    this.primaryGlow = AppPalette.primaryGlow,
    this.secondary = AppPalette.secondary,
    this.mutedForeground = AppPalette.mutedForeground,
    this.destructive = AppPalette.destructive,
    this.success = AppPalette.success,
    this.warning = AppPalette.warning,
    this.info = AppPalette.info,

    this.sidebarForeground = AppPalette.sidebarForeground,
    this.sidebarPrimary = AppPalette.sidebarPrimary,
    this.sidebarAccent = AppPalette.sidebarAccent,
    this.sidebarBorder = AppPalette.sidebarBorder,
    this.sidebarRing = AppPalette.sidebarRing,

    this.darkBackground = AppPalette.darkBackground,
    this.darkForeground = AppPalette.darkForeground,
    this.darkPrimaryForeground = AppPalette.darkPrimaryForeground,
    this.darkSecondary = AppPalette.darkSecondary,
    this.darkMutedForeground = AppPalette.darkMutedForeground,
    this.darkDestructive = AppPalette.darkDestructive,
    this.darkRing = AppPalette.darkRing,
    this.darkSidebarForeground = AppPalette.darkSidebarForeground,
  });

  @override
  AppColors copyWith({
    Color? background,
    Color? foreground,
    Color? card,
    Color? primary,
    Color? primaryGlow,
    Color? secondary,
    Color? mutedForeground,
    Color? destructive,
    Color? success,
    Color? warning,
    Color? info,
    Color? sidebarForeground,
    Color? sidebarPrimary,
    Color? sidebarAccent,
    Color? sidebarBorder,
    Color? sidebarRing,
    Color? darkBackground,
    Color? darkForeground,
    Color? darkPrimaryForeground,
    Color? darkSecondary,
    Color? darkMutedForeground,
    Color? darkDestructive,
    Color? darkRing,
    Color? darkSidebarForeground,
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
      darkPrimaryForeground:
      darkPrimaryForeground ?? this.darkPrimaryForeground,
      darkSecondary: darkSecondary ?? this.darkSecondary,
      darkMutedForeground: darkMutedForeground ?? this.darkMutedForeground,
      darkDestructive: darkDestructive ?? this.darkDestructive,
      darkRing: darkRing ?? this.darkRing,
      darkSidebarForeground:
      darkSidebarForeground ?? this.darkSidebarForeground,
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
      mutedForeground:
      Color.lerp(mutedForeground, other.mutedForeground, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      sidebarForeground:
      Color.lerp(sidebarForeground, other.sidebarForeground, t)!,
      sidebarPrimary: Color.lerp(sidebarPrimary, other.sidebarPrimary, t)!,
      sidebarAccent: Color.lerp(sidebarAccent, other.sidebarAccent, t)!,
      sidebarBorder: Color.lerp(sidebarBorder, other.sidebarBorder, t)!,
      sidebarRing: Color.lerp(sidebarRing, other.sidebarRing, t)!,
      darkBackground: Color.lerp(darkBackground, other.darkBackground, t)!,
      darkForeground: Color.lerp(darkForeground, other.darkForeground, t)!,
      darkPrimaryForeground:
      Color.lerp(darkPrimaryForeground, other.darkPrimaryForeground, t)!,
      darkSecondary: Color.lerp(darkSecondary, other.darkSecondary, t)!,
      darkMutedForeground:
      Color.lerp(darkMutedForeground, other.darkMutedForeground, t)!,
      darkDestructive:
      Color.lerp(darkDestructive, other.darkDestructive, t)!,
      darkRing: Color.lerp(darkRing, other.darkRing, t)!,
      darkSidebarForeground:
      Color.lerp(darkSidebarForeground, other.darkSidebarForeground, t)!,
    );
  }
}

