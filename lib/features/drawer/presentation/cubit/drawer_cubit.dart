import 'package:app/core/error/apiResult.dart';
import 'package:app/core/network/remote/handle_dio_exception.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/features/drawer/data/model/change_email/change_email_request.dart';
import 'package:app/features/drawer/data/model/change_password_request.dart';
import 'package:app/features/drawer/domain/use_cases/change_email_use_case.dart';
import 'package:app/features/drawer/domain/use_cases/change_password_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_states.dart';

@lazySingleton
class DrawerCubit extends Cubit<DrawerStates> {
  DrawerCubit(
      {required this.changePasswordUseCase,
      required this.sharedPreferencesUtils,
      required this.changeEmailUseCase})
      : super(DrawerInitial());
  ChangePasswordUseCase changePasswordUseCase;
  SharedPreferencesUtils sharedPreferencesUtils;
  ChangeEmailUseCase changeEmailUseCase;
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
    await sharedPreferencesUtils.saveData(key: 'theme', value: newTheme);
  }

  String? getTheme() {
    return sharedPreferencesUtils.getString('theme');
  }

  Future<void> loadThemeData() async {
    String? oldTheme = getTheme();
    if (oldTheme != null) {
      themeMode = oldTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  changePassword(ChangePasswordRequest request) async {
    emit(ChangePasswordLoadingState());
    final ans = await changePasswordUseCase(request);
    switch (ans) {
      case ApiResultSuccess():
        emit(ChangePasswordSuccessState(ans.data));
      case ApiresultError():
        emit(ChangePasswordErrorState(ans.message));
    }
  }

  changeEmail(ChangeEmailRequest request) async {
    emit(ChangeEmailLoadingState());
    final ans = await changeEmailUseCase(request);
    switch (ans) {
      case ApiResultSuccess():
        emit(ChangeEmailSuccessState(ans.data));
      case ApiresultError():
        emit(ChangeEmailErrorState(ans.message));
    }
  }

  void changeLanguage(String selctedLanguage) {
    if (selctedLanguage == languageCode) return;
    languageCode = selctedLanguage;
    saveLanguage(languageCode);
    emit(DrawerThemeState());
  }

  Future<void> saveLanguage(String language) async {
    await sharedPreferencesUtils.saveData(key: 'language', value: language);
  }

  String? getLanguage() {
    return sharedPreferencesUtils.getString('language');
  }

  Future<void> loadLanguage() async {
    String? language = getLanguage();
    if (language != null) {
      languageCode = language;
    }
  }

  Future<void> logout() async {
    Dio dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
    ));

    try {
      final token = sharedPreferencesUtils.getString(CacheConstant.tokenKey);
      emit(LogOutLoading());

      if (token == null || token.isEmpty) {
        UIUtils.showMessage("You are not logged in.");
        return;
      }

      // Make the API call
      final response = await dio.post(
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
        sharedPreferencesUtils.removeData(key: CacheConstant.emailKey);
        sharedPreferencesUtils.removeData(key: CacheConstant.userId);
        sharedPreferencesUtils.removeData(key: CacheConstant.userAccountStatus);
        sharedPreferencesUtils.removeData(key: CacheConstant.imagePhoto);
        sharedPreferencesUtils.removeData(
            key: CacheConstant.imagePhotoFromFile);
        sharedPreferencesUtils.removeData(key: CacheConstant.userAccountStatus);
        sharedPreferencesUtils.removeData(key: CacheConstant.tokenKey);
        sharedPreferencesUtils.removeData(key: CacheConstant.userRole);
        sharedPreferencesUtils.removeData(key: CacheConstant.nameKey);
        print(
            'the code of language now is ${sharedPreferencesUtils.getString('language')}');
        // await sharedPreferencesUtils.clearAllData();
        emit(LogOutSuccess());
      }
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      emit(LogOutErrorr(exception));
    }
  }

  Future<void> deleteAccount() async {
    Dio dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
    ));
    try {
      final token = sharedPreferencesUtils.getString(CacheConstant.tokenKey);
      final userId =
          sharedPreferencesUtils.getData(key: CacheConstant.userId) as int;
      emit(DeleteAccountLoading());
      final response = await dio.delete(
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
        await sharedPreferencesUtils.clearAllData();

        emit(DeleteAccountSuccess());
      }
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      emit(DeleteAccountError(exception));
    }
  }
}
