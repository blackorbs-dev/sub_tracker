import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../features/subscription/domain/repository/subscription_repository.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit(this._repository) : super(ThemeMode.light);

  final SubscriptionRepository _repository;

  void toggleTheme() {
    final isLight = state == ThemeMode.light;
    if (isLight) {
      // subtract one day from current subscription start state on toggle night mode
      _repository.adjustCurrentSubStartDate();
    }
    emit(isLight ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final themeString = json['theme'] as String?;
    if (themeString == null) return null;
    return ThemeMode.values.firstWhere(
          (mode) => mode.toString() == themeString,
      orElse: () => ThemeMode.light,
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme': state.toString()};
  }
}
