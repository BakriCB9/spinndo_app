import 'package:app/core/resources/styles_manager.dart';
import 'package:app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'font_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    /// Main Colors
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.white,
        foregroundColor: ColorManager.black),
    primaryColor: ColorManager.primary,
    iconTheme: IconThemeData(color: ColorManager.primary, size: 40.sp),
    primaryColorLight: ColorManager.black,
    primaryColorDark: Colors.white,
    scaffoldBackgroundColor: Colors.white.withOpacity(0.95),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: ColorManager.black,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(ColorManager.black),
          backgroundColor: const WidgetStatePropertyAll(ColorManager.primary),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s28.r))),
          padding:
              WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12.h))),
    ),
    textButtonTheme: TextButtonThemeData(),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s28.r)),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      // splashColor: ColorManager.lightPrimary,
    ),

    cardTheme: CardTheme(
      color: ColorManager.greyWhite,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16.r),
      ),
      margin: EdgeInsets.only(bottom: AppSize.s16.sp),
    ),

    textTheme: TextTheme(
      labelLarge: getSemiBoldStyle(
          color: ColorManager.primary, fontSize: FontSize.s32.sp),
      labelMedium: getSemiBoldStyle(
          color: ColorManager.black, fontSize: FontSize.s30.sp),
      labelSmall:
          getSemiBoldStyle(color: ColorManager.grey, fontSize: FontSize.s28.sp),

      //drop down
      displayMedium:
          getRegularStyle(color: ColorManager.black, fontSize: FontSize.s30.sp),
      //guest
      titleSmall:
          getRegularStyle(color: ColorManager.black, fontSize: FontSize.s24.sp),
      //text butt
      titleMedium: getMediumStyle(
          color: ColorManager.black,
          fontSize: FontSize.s28.sp,
          fontFamily: "WorkSans",
          fontWeight: FontWeight.w600),
      //title spinndo
      titleLarge: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s54.sp,
      ),
      //text in body
      bodySmall:
          getRegularStyle(color: ColorManager.black, fontSize: FontSize.s32.sp),
      //client word
      bodyMedium: getMediumStyle(
        color: ColorManager.black,
        fontSize: FontSize.s32.sp,
      ),

      //elevated butt
      bodyLarge: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s32.sp,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.white,
      prefixIconColor: ColorManager.primary,

      suffixIconColor: ColorManager.primary,
      contentPadding: EdgeInsets.all(AppPadding.p8.sp),
      // hintStyle: getRegularStyle(
      //   color: ColorManager.grey,
      //   fontSize: FontSize.s13,
      // ),
      labelStyle:
          getRegularStyle(color: ColorManager.black, fontSize: FontSize.s30.sp),
      hintStyle:
          getRegularStyle(color: ColorManager.black, fontSize: FontSize.s30.sp),
      errorStyle: getRegularStyle(color: Colors.red, fontSize: FontSize.s20.sp),
      filled: true,

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
    ),

    // bottomSheetTheme: BottomSheetThemeData(
    //   backgroundColor: ColorManager.primary.withOpacity(0.6),
    //   elevation: 10,
    //   clipBehavior: Clip.antiAlias,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(
    //       top: Radius.circular(24),
    //     ),
    //   ),
    // ),

    /// Icon Theme
    // iconTheme: const IconThemeData(
    //   color: Colors.white70,
    // ),
  );
  static ThemeData darkTheme = ThemeData(
    /// Main Colors
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.darkBlue,
        foregroundColor: ColorManager.white),
    primaryColor: ColorManager.primary,
    iconTheme: IconThemeData(color: ColorManager.primary, size: 40.sp),

    primaryColorLight: ColorManager.white,
    primaryColorDark: ColorManager.darkBlue,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorManager.white,
        elevation: 0),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(ColorManager.white),
          backgroundColor: const WidgetStatePropertyAll(ColorManager.primary),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s28.r))),
          padding:
              WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12.h))),
    ),
    textButtonTheme: TextButtonThemeData(),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s28.r)),

      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      // splashColor: ColorManager.lightPrimary,
    ),

    cardTheme: CardTheme(
      color: ColorManager.darkBlue,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16.r),
      ),
      margin: EdgeInsets.only(bottom: AppSize.s16.sp),
    ),

    textTheme: TextTheme(
      labelLarge: getSemiBoldStyle(
          color: ColorManager.primary, fontSize: FontSize.s32.sp),
      labelMedium: getSemiBoldStyle(
          color: ColorManager.white, fontSize: FontSize.s30.sp),
      labelSmall:
          getSemiBoldStyle(color: ColorManager.grey, fontSize: FontSize.s28.sp),
      //drop down
      displayMedium:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s30.sp),
      //guest
      titleSmall:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s24.sp),
      //text butt
      titleMedium: getMediumStyle(
          color: ColorManager.white,
          fontSize: FontSize.s28.sp,
          fontFamily: "WorkSans",
          fontWeight: FontWeight.w600),
      //title spinndo
      titleLarge: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s54.sp,
      ),
      //text in body
      bodySmall:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s32.sp),
      //client word
      bodyMedium: getMediumStyle(
        color: ColorManager.white,
        fontSize: FontSize.s32.sp,
      ),

      //elevated butt
      bodyLarge: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s32.sp,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.darkBlue,
      prefixIconColor: ColorManager.primary,
      suffixIconColor: ColorManager.primary,
      contentPadding: EdgeInsets.all(AppPadding.p8.sp),
      // hintStyle: getRegularStyle(
      //   color: ColorManager.grey,
      //   fontSize: FontSize.s13,
      // ),
      labelStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s30.sp),
      hintStyle:
          getRegularStyle(color: ColorManager.white, fontSize: FontSize.s30.sp),
      errorStyle: getRegularStyle(
          color: Colors.red.shade400, fontSize: FontSize.s20.sp),
      filled: true,

      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s28.r)),
          borderSide: BorderSide.none),
    ),

    // bottomSheetTheme: BottomSheetThemeData(
    //   backgroundColor: ColorManager.primary.withOpacity(0.6),
    //   elevation: 10,
    //   clipBehavior: Clip.antiAlias,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(
    //       top: Radius.circular(24),
    //     ),
    //   ),
    // ),

    /// Icon Theme
    // iconTheme: const IconThemeData(
    //   color: Colors.white70,
    // ),
  );
}
