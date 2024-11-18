
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/resources/styles_manager.dart';
import 'package:snipp/core/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';


ThemeData getAppTheme() {
  return ThemeData(
    /// Main Colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.blueGrey,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey,
    primarySwatch: Colors.deepPurple,
    // splashColor: ColorManager.lightPrimary,
    scaffoldBackgroundColor: ColorManager.blueGrey,

    /// App Bar Theme
    // appBarTheme: AppBarTheme(
    //   color: Colors.transparent,
    //   shadowColor: Colors.transparent,
    //
    //   elevation: 0,
    // ),

    /// Button Theme
    ///
    ///

      elevatedButtonTheme:ElevatedButtonThemeData(

        style: ButtonStyle(
          backgroundColor:
          const WidgetStatePropertyAll(ColorManager.primary),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(30.r))),
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 12.h))),),
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      // splashColor: ColorManager.lightPrimary,
    ),

    /// Elevated Button Theme
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     textStyle: getRegularStyle(
    //       color: ColorManager.white,
    //       fontSize: FontSize.s18,
    //     ),
    //     backgroundColor: ColorManager.primary,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(AppSize.s12),
    //     ),
    //   ),
    // ),

    /// Text Theme
    textTheme: TextTheme(

      titleSmall: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s13
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s24,
      ),
      titleLarge: getBoldStyle(
        color: ColorManager.green,
        fontSize: FontSize.s32,
      ),

      bodySmall: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s13
      ),
      bodyMedium: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s24,
      ),
      bodyLarge: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s32,
      ),
    ),

    /// Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      prefixIconColor: ColorManager.primary,
      suffixIconColor: ColorManager.primary,
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      // hintStyle: getRegularStyle(
      //   color: ColorManager.grey,
      //   fontSize: FontSize.s13,
      // ),
      labelStyle: getThinStyle(
        color: ColorManager.darkGrey,
      ),
      errorStyle: getRegularStyle(
        color: ColorManager.green,
      ),
      enabledBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: ColorManager.lightGrey,
          width: AppSize.s1_5.w,
        ),
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: ColorManager.lightGrey,
          width: AppSize.s1_5.w,
        ),
      ),
      errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: ColorManager.green,
          width: AppSize.s4.w,
        ),
      ),     border:  OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      borderSide: BorderSide(
        color: ColorManager.babyBlue,
        width: AppSize.s4.w,
      ),
    ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: ColorManager.lightGrey,
          width: AppSize.s1_5.w,
        ),
      ),
    ),



    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorManager.primary.withOpacity(0.6),
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
    ),

    /// Icon Theme
    iconTheme: const IconThemeData(
      color: Colors.white70,
    ),

    /// Card Theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
  );
}
