import 'package:app/core/resources/styles_manager.dart';
import 'package:app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'font_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.seed),
    fontFamily: 'Lato',
    menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(TextStyle(
              fontSize: 30.sp,
              color: ColorManager.black,
              fontFamily: "Lato",
            )),
            foregroundColor: WidgetStatePropertyAll(ColorManager.black))),
    dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(ColorManager.white)),
        textStyle: TextStyle(fontSize: 25.sp, color: Colors.black)),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: ColorManager.white),

    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.primary,
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: ColorManager.primary,
          fontFamily: "Lato"),
      unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          fontFamily: "Lato"
      ),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: 2,
        ),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorManager.white,
        foregroundColor: ColorManager.black),
    primaryColor: ColorManager.primary,
    iconTheme: IconThemeData(
      color: ColorManager.primary,
      size: 40.sp,
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Lato",
        color: ColorManager.black2,
      ),
    ),
    primaryColorLight: ColorManager.black2,
    primaryColorDark: Colors.white,
    shadowColor: ColorManager.lightShadow,
    scaffoldBackgroundColor: Colors.white.withOpacity(0.97),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          fontSize: 45.sp,
          color: ColorManager.black,
          fontWeight: FontWeight.w600),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white.withOpacity(0.95),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: ColorManager.black,
      elevation: 0,
    ),
    dialogBackgroundColor: ColorManager.white,
    checkboxTheme: const CheckboxThemeData(
        checkColor: WidgetStatePropertyAll(ColorManager.white)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontFamily: "Lato",
            ),
          ),
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
      labelLarge: getMediumStyle(
          color: ColorManager.grey2,
          fontSize: FontSize.s32.sp,
          fontWeight: FontWeight.w600,
          fontFamily: "Lato"),
      labelMedium: getMediumStyle(
          color: ColorManager.textColorLight,
          fontSize: FontSize.s30.sp,
          fontFamily: "Lato"),
      labelSmall: getMediumStyle(
          color: ColorManager.grey,
          fontSize: FontSize.s28.sp,
          fontFamily: "Lato"),
      //drop down
      displayMedium: getRegularStyle(
          color: ColorManager.grey2,
          fontSize: FontSize.s30.sp,
          fontFamily: "Lato"),
      //guest
      titleSmall: getRegularStyle(
          color: ColorManager.black,
          fontSize: FontSize.s24.sp,
          fontFamily: "Lato"),
      //text butt
      titleMedium: getMediumStyle(
          color: ColorManager.textColor,
          fontSize: FontSize.s32.sp,
          fontFamily: "Lato",
          fontWeight: FontWeight.w600),
      //title spinndo
      titleLarge: getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s48.sp,
          fontFamily: "Lato"),
      //text in body
      bodySmall: getRegularStyle(
          color: ColorManager.black,
          fontSize: FontSize.s32.sp,
          fontFamily: "Lato"),
      //client word
      bodyMedium: getMediumStyle(
          color: ColorManager.black,
          fontSize: FontSize.s32.sp,
          fontFamily: "Lato"),

      //elevated butt
      bodyLarge: getBoldStyle(
          color: ColorManager.white,
          fontSize: FontSize.s32.sp,
          fontFamily: "Lato"),
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
    ///
    ///
    colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primaryLight),
    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.primary,
      unselectedLabelColor: ColorManager.grey,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        fontFamily: "Lato",
        color: ColorManager.primary,
      ),
      unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal, fontSize: 16, fontFamily: "Lato"),
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: 2,
        ),
      ),
    ),
    fontFamily: 'Lato',
    shadowColor: ColorManager.darkShadow,
    menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(TextStyle(
              fontSize: 30.sp,
              color: ColorManager.white,
              fontFamily: "Lato",
            )),
            foregroundColor: WidgetStatePropertyAll(ColorManager.white))),
    dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
            backgroundColor:
            WidgetStatePropertyAll(ColorManager.darkTextFieldBg)),
        textStyle: TextStyle(fontSize: 30.sp, color: Colors.white)),
    bottomSheetTheme:
    BottomSheetThemeData(backgroundColor: ColorManager.darkTextFieldBg),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManager.darkTextFieldBg,
        foregroundColor: ColorManager.white),
    primaryColor: ColorManager.primaryDark,
    iconTheme: IconThemeData(color: ColorManager.primary, size: 40.sp),
    dialogBackgroundColor: ColorManager.darkTextFieldBg,
    primaryColorLight: ColorManager.white,
    primaryColorDark: ColorManager.darkTextFieldBg,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: ColorManager.darkTextFieldBg,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: ColorManager.white,
        elevation: 0),

    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Lato",
        color: ColorManager.lightWhite,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontFamily: "Lato",
            ),
          ),
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
      color: ColorManager.darkTextFieldBg,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16.r),
      ),
      margin: EdgeInsets.only(bottom: AppSize.s16.sp),
    ),

    textTheme: TextTheme(
      labelLarge: getMediumStyle(
          color: ColorManager.white,
          fontSize: FontSize.s36.sp,
          fontWeight: FontWeight.w600,
          fontFamily: "Lato"),
      labelMedium: getMediumStyle(
          color: ColorManager.textColorLight,
          fontSize: FontSize.s30.sp,
          fontFamily: "Lato"),
      labelSmall: getMediumStyle(
          color: ColorManager.grey,
          fontSize: FontSize.s28.sp,
          fontFamily: "Lato"),
      //drop down
      displayMedium: getRegularStyle(
          color: ColorManager.greyWhite,
          fontSize: FontSize.s30.sp,
          fontFamily: "Lato"),
      //guest
      titleSmall: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s24.sp,
          fontFamily: "Lato"),
      //text butt
      titleMedium: getMediumStyle(
          color: ColorManager.lightGrey,
          fontSize: FontSize.s32.sp,
          fontFamily: "Lato",
          fontWeight: FontWeight.w600),
      //title spinndo
      titleLarge: getBoldStyle(
          color: ColorManager.white,
          fontSize: FontSize.s48.sp,
          fontFamily: "Lato"),
      //text in body
      bodySmall: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s32.sp,
          fontFamily: "Lato"),
      //client word
      bodyMedium: getMediumStyle(
          color: ColorManager.white,
          fontSize: FontSize.s32.sp,
          fontFamily: "Lato"),

      //elevated butt
      bodyLarge: getBoldStyle(
          color: ColorManager.white,
          fontSize: FontSize.s32.sp,
          fontFamily: "Lato"),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: ColorManager.darkTextFieldBg,
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
