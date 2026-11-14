import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeModeCubit extends HydratedCubit<ThemeMode> {
  ThemeModeCubit() : super(.light);

  Future<void> toggle() async {
    final ThemeMode newMode = state == .light ? .dark : .light;

    emit(newMode);
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) => {'mode': state.index};

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) =>
      ThemeMode.values[json['mode'] as int];
}
