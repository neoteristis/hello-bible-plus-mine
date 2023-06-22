import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

const brightness = 'brightness';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences sharedPreferences;
  ThemeBloc({required this.sharedPreferences}) : super(const ThemeState()) {
    on<ThemeStarted>(_onThemeStarted);
    on<ThemeChanged>(_onThemeChanged);
  }

  void _onThemeStarted(
    ThemeStarted event,
    Emitter<ThemeState> emit,
  ) async {
    // final context = event.context;
    ThemeMode? themeMode;
    final isLight = sharedPreferences.getBool(brightness);
    if (isLight != null) {
      themeMode = isLight ? ThemeMode.light : ThemeMode.dark;
      emit(state.copyWith(themeMode: themeMode));
    }
    // final brightness = Theme.of(context).brightness;
  }

  void _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    ThemeMode? themeMode;
    final context = event.context;
    if (state.themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else if (state.themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      final isLight = Theme.of(context).brightness == Brightness.dark;
      themeMode = isLight ? ThemeMode.dark : ThemeMode.light;
    }
    print(themeMode);
    await sharedPreferences.setBool(brightness, themeMode == ThemeMode.light);
    emit(state.copyWith(themeMode: themeMode));
  }
}
