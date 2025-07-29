import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  // Root Theme
  final Color background;
  final Color foreground;
  final Color card;
  final Color cardForeground;
  final Color primary;
  final Color primaryForeground;
  final Color primaryGlow;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color destructive;
  final Color success;
  final Color warning;
  final Color info;
  final Color border;
  final Color ring;

  // Sidebar
  final Color sidebarBackground;
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarAccent;
  final Color sidebarBorder;
  final Color sidebarRing;

  // Dark Theme
  final Color darkBackground;
  final Color darkForeground;
  final Color darkPrimary;
  final Color darkPrimaryForeground;
  final Color darkSecondary;
  final Color darkMutedForeground;
  final Color darkDestructive;
  final Color darkRing;
  final Color darkSidebarBackground;
  final Color darkSidebarForeground;
  final Color darkSidebarPrimary;

  const AppColors({
    // Root
    this.background = const Color(0xFF0a0a0b),
    this.foreground = const Color(0xFFfafafa),
    this.card = const Color(0xFF0a0a0b),
    this.cardForeground = const Color(0xFFfafafa),
    this.primary = const Color(0xFF8b5cf6),
    this.primaryForeground = const Color(0xFFfafafa),
    this.primaryGlow = const Color(0xFFa78bfa),
    this.secondary = const Color(0xFF27272a),
    this.secondaryForeground = const Color(0xFFfafafa),
    this.muted = const Color(0xFF27272a),
    this.mutedForeground = const Color(0xFFa1a1aa),
    this.accent = const Color(0xFF27272a),
    this.destructive = const Color(0xFFef4444),
    this.success = const Color(0xFF16a34a),
    this.warning = const Color(0xFFf59e0b),
    this.info = const Color(0xFF0ea5e9),
    this.border = const Color(0xFF27272a),
    this.ring = const Color(0xFF8b5cf6),

    // Sidebar
    this.sidebarBackground = const Color(0xFFfafafa),
    this.sidebarForeground = const Color(0xFF404040),
    this.sidebarPrimary = const Color(0xFF171717),
    this.sidebarAccent = const Color(0xFFf4f4f5),
    this.sidebarBorder = const Color(0xFFe4e4e7),
    this.sidebarRing = const Color(0xFF3b82f6),

    // Dark Theme
    this.darkBackground = const Color(0xFF020617),
    this.darkForeground = const Color(0xFFf8fafc),
    this.darkPrimary = const Color(0xFFf8fafc),
    this.darkPrimaryForeground = const Color(0xFF0f172a),
    this.darkSecondary = const Color(0xFF1e293b),
    this.darkMutedForeground = const Color(0xFF94a3b8),
    this.darkDestructive = const Color(0xFF7f1d1d),
    this.darkRing = const Color(0xFFcbd5e1),
    this.darkSidebarBackground = const Color(0xFF0f172a),
    this.darkSidebarForeground = const Color(0xFFf1f5f9),
    this.darkSidebarPrimary = const Color(0xFF3b82f6),
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
      cardForeground: cardForeground ?? this.cardForeground,
      primary: primary ?? this.primary,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      primaryGlow: primaryGlow ?? this.primaryGlow,
      secondary: secondary ?? this.secondary,
      secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      muted: muted ?? this.muted,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      accent: accent ?? this.accent,
      destructive: destructive ?? this.destructive,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      border: border ?? this.border,
      ring: ring ?? this.ring,

      sidebarBackground: sidebarBackground ?? this.sidebarBackground,
      sidebarForeground: sidebarForeground ?? this.sidebarForeground,
      sidebarPrimary: sidebarPrimary ?? this.sidebarPrimary,
      sidebarAccent: sidebarAccent ?? this.sidebarAccent,
      sidebarBorder: sidebarBorder ?? this.sidebarBorder,
      sidebarRing: sidebarRing ?? this.sidebarRing,

      darkBackground: darkBackground ?? this.darkBackground,
      darkForeground: darkForeground ?? this.darkForeground,
      darkPrimary: darkPrimary ?? this.darkPrimary,
      darkPrimaryForeground: darkPrimaryForeground ?? this.darkPrimaryForeground,
      darkSecondary: darkSecondary ?? this.darkSecondary,
      darkMutedForeground: darkMutedForeground ?? this.darkMutedForeground,
      darkDestructive: darkDestructive ?? this.darkDestructive,
      darkRing: darkRing ?? this.darkRing,
      darkSidebarBackground: darkSidebarBackground ?? this.darkSidebarBackground,
      darkSidebarForeground: darkSidebarForeground ?? this.darkSidebarForeground,
      darkSidebarPrimary: darkSidebarPrimary ?? this.darkSidebarPrimary,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardForeground: Color.lerp(cardForeground, other.cardForeground, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryForeground: Color.lerp(primaryForeground, other.primaryForeground, t)!,
      primaryGlow: Color.lerp(primaryGlow, other.primaryGlow, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryForeground: Color.lerp(secondaryForeground, other.secondaryForeground, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      border: Color.lerp(border, other.border, t)!,
      ring: Color.lerp(ring, other.ring, t)!,

      sidebarBackground: Color.lerp(sidebarBackground, other.sidebarBackground, t)!,
      sidebarForeground: Color.lerp(sidebarForeground, other.sidebarForeground, t)!,
      sidebarPrimary: Color.lerp(sidebarPrimary, other.sidebarPrimary, t)!,
      sidebarAccent: Color.lerp(sidebarAccent, other.sidebarAccent, t)!,
      sidebarBorder: Color.lerp(sidebarBorder, other.sidebarBorder, t)!,
      sidebarRing: Color.lerp(sidebarRing, other.sidebarRing, t)!,

      darkBackground: Color.lerp(darkBackground, other.darkBackground, t)!,
      darkForeground: Color.lerp(darkForeground, other.darkForeground, t)!,
      darkPrimary: Color.lerp(darkPrimary, other.darkPrimary, t)!,
      darkPrimaryForeground: Color.lerp(darkPrimaryForeground, other.darkPrimaryForeground, t)!,
      darkSecondary: Color.lerp(darkSecondary, other.darkSecondary, t)!,
      darkMutedForeground: Color.lerp(darkMutedForeground, other.darkMutedForeground, t)!,
      darkDestructive: Color.lerp(darkDestructive, other.darkDestructive, t)!,
      darkRing: Color.lerp(darkRing, other.darkRing, t)!,
      darkSidebarBackground: Color.lerp(darkSidebarBackground, other.darkSidebarBackground, t)!,
      darkSidebarForeground: Color.lerp(darkSidebarForeground, other.darkSidebarForeground, t)!,
      darkSidebarPrimary: Color.lerp(darkSidebarPrimary, other.darkSidebarPrimary, t)!,
    );
  }
}
