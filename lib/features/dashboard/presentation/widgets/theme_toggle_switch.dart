import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/theme/colors.dart';

import '../../../../core/theme/theme_cubit.dart';

class ThemeToggleSwitch extends StatelessWidget{
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return GestureDetector(
      onTap: context.read<ThemeCubit>().toggleTheme,
      child: Container(
          width: 60, height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDark ? AppPalette.warning : AppPalette.darkMutedForeground,
          ),
          margin: const EdgeInsets.only(right: 16),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 400),
            alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: isDark ? AppPalette.darkPrimaryForeground : AppPalette.sidebarAccent,
                child: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  size: 16,
                  color: isDark ? AppPalette.warning : AppPalette.darkPrimaryForeground,
                ),
              ),
            ),
          )
      ),
    );
  }

}