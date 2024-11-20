
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snipp/core/resources/color_manager.dart';
import 'package:snipp/features/drawer/presentation/cubit/drawer_states.dart';

@lazySingleton
class DrawerCubit extends Cubit<DrawerStates> {
  DrawerCubit(  { required  this.sharedPreferences}) :super(DrawerInitial());
   final SharedPreferences sharedPreferences;
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';
  Color get backgroundColor =>
      themeMode == ThemeMode.light ? ColorManager.secondPrimary :ColorManager.babyBlue ;

  void changeTheme(ThemeMode selctedTheme) {
    themeMode = selctedTheme;
    saveTheme(themeMode);
  emit(DrawerThemeState());
  }
  Future<void> saveTheme(ThemeMode themeMode) async {
    String newTheme = themeMode == ThemeMode.dark ? "dark" : "light";
    await sharedPreferences.setString('theme', newTheme);
  }

  String? getTheme() {
    return sharedPreferences.getString('theme');
  }

  Future<void> loadThemeData() async {
    String? oldTheme = getTheme();
    if (oldTheme != null) {
      themeMode = oldTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }
  void changeLanguage(String selctedLanguage) {
    if (selctedLanguage == languageCode) return;
    languageCode = selctedLanguage;
    saveLanguage(languageCode);
    emit(DrawerThemeState());
  }
  Future<void> saveLanguage( String language) async {

    await sharedPreferences.setString('language', language);
  }

  String? getLanguage() {
    return sharedPreferences.getString('language');
  }

  Future<void> loadLanguage() async {
    String? language = getLanguage();
    if (language != null) {
      languageCode = language;
// emit(state)
    }
  }
}
