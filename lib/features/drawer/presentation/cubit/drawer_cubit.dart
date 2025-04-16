import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';
import 'package:app/main.dart';

@lazySingleton
class DrawerCubit extends Cubit<DrawerStates> {
  DrawerCubit({required this.sharedPreferences}) : super(DrawerInitial());
  SharedPreferences sharedPreferences;
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';
  Color get backgroundColor => themeMode == ThemeMode.light
      ? ColorManager.backgroundColor
      : ColorManager.grey2;

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
    sharedPreferences = await SharedPreferences.getInstance();

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

  Future<void> saveLanguage(String language) async {
    await sharedPreferences.setString('language', language);
  }

  String? getLanguage() {
    return sharedPreferences.getString('language');
  }

  Future<void> loadLanguage() async {
    sharedPreferences = await SharedPreferences.getInstance();

    String? language = getLanguage();
    if (language != null) {
      languageCode = language;
// emit(state)
    }
  }

  Future<void> logout() async {
    Dio _dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout:const  Duration(seconds: 120),
      // receiveTimeout:const  Duration(seconds: 120)
    ));

    try {
      final token = sharedPref.getString(CacheConstant.tokenKey);
      emit(LogOutLoading());
      // Ensure token is not null or empty
      if (token == null || token.isEmpty) {
        UIUtils.showMessage("You are not logged in.");
        return;
      }

      // Make the API call
      final response = await _dio!.post(
        '${ApiConstant.logoutEndPoint}',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      // Check the response status
      if (response.statusCode == 200) {
        await sharedPref.remove(CacheConstant.tokenKey);
        await sharedPref.remove(CacheConstant.emailKey);
        await sharedPref.remove(CacheConstant.imagePhoto);
        await sharedPref.remove(CacheConstant.imagePhotoFromLogin);
        await sharedPref.remove(CacheConstant.userId);
        await sharedPref.clear();
        emit(LogOutSuccess());
      }
    } catch (error) {
      // Log and show the error
      debugPrint("Logout Error: $error");
      emit(LogOutErrorr("An error occurred. Please try again."));
    }
  }

  Future<void> deleteAccount() async {
    Dio _dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
    ));
    try {
      final token = sharedPref.getString(CacheConstant.tokenKey);
      final userId = sharedPref.getInt(CacheConstant.userId);
      emit(DeleteAccountLoading());
      final response = await _dio.delete(
        '${ApiConstant.deleteMyAccount}/$userId',
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      if (response.statusCode == 200) {
        // Clear user session

        await sharedPref.remove(CacheConstant.tokenKey);
        await sharedPref.remove(CacheConstant.emailKey);
        await sharedPref.remove(CacheConstant.imagePhoto);
        await sharedPref.remove(CacheConstant.nameKey);
        await sharedPref.remove(CacheConstant.imagePhotoFromLogin);
        await sharedPref.remove(CacheConstant.userRole);
        await sharedPreferences.remove(CacheConstant.semailKey);
        emit(DeleteAccountSuccess());
      }
    } catch (e) {
      print('the error is %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ${e}');
      emit(DeleteAccountError("An error occurred. Please try again."));
    }
  }
}
