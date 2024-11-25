
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snipp/core/resources/styles_manager.dart';
import 'package:snipp/core/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

class ThemeManager {
  static ThemeData lightTheme=ThemeData(
    /// Main Colors
    primaryColor: ColorManager.primary,

    primaryColorLight: ColorManager.blueGrey,
    primaryColorDark: ColorManager.black,
    scaffoldBackgroundColor: ColorManager.white2,
appBarTheme: AppBarTheme(backgroundColor: ColorManager.white2,foregroundColor: ColorManager.black,elevation: 0 ),

    elevatedButtonTheme:ElevatedButtonThemeData(

      style: ButtonStyle(foregroundColor:  WidgetStatePropertyAll(ColorManager.black),
          backgroundColor:
          const WidgetStatePropertyAll(ColorManager.primary),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(30.r))),
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 12.h))),),
    textButtonTheme: TextButtonThemeData(),
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      // splashColor: ColorManager.lightPrimary,
    ),



    textTheme: TextTheme(
      //guest
      titleSmall: getRegularStyle(
          color: ColorManager.primary,
          fontSize: FontSize.s24.sp
      ),
      //text butt
      titleMedium: getMediumStyle(
          color: ColorManager.primary,
          fontSize: FontSize.s28.sp,
          fontFamily: "WorkSans",
          fontWeight: FontWeight.w600
      ),
      //title spinndo
      titleLarge: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s54.sp,
      ),
      //text in body
      bodySmall: getRegularStyle(
          color: ColorManager.black,
          fontSize: FontSize.s32.sp
      ),
      //client word
      bodyMedium: getMediumStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s36.sp,
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
      labelStyle: getThinStyle(
          color: ColorManager.black,
          fontSize: FontSize.s32.sp
      ),
      hintStyle:  getThinStyle(
          color: ColorManager.black,
          fontSize: FontSize.s32.sp
      ),
      errorStyle: getRegularStyle(
          color: Colors.red,
          fontSize: FontSize.s28.sp

      ),
      filled: true,

      enabledBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: ColorManager.grey2,
          width: AppSize.s1.w,
        ),
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: ColorManager.grey2,
          width: AppSize.s1.w,
        ),
      ),
      errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: Colors.red,
          width: AppSize.s1.w,
        ),
      ),     border:  OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
      borderSide: BorderSide(
        color: ColorManager.grey2,
        width: AppSize.s1.w,
      ),
    ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: Colors.red,
          width: AppSize.s1.w,
        ),
      ),

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
  static ThemeData darkTheme =ThemeData(
    /// Main Colors
    primaryColor: ColorManager.black,

    primaryColorLight: ColorManager.blueGrey,
    primaryColorDark: ColorManager.black,
    scaffoldBackgroundColor: ColorManager.lightBlack,
    appBarTheme: AppBarTheme(backgroundColor: ColorManager.lightBlack,foregroundColor: ColorManager.primary,elevation: 0 ),

    elevatedButtonTheme:ElevatedButtonThemeData(

      style: ButtonStyle(foregroundColor:  WidgetStatePropertyAll(ColorManager.black),
          backgroundColor:
          const WidgetStatePropertyAll(ColorManager.primary),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(30.r))),
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 12.h))),),
    textButtonTheme: TextButtonThemeData(),
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      // splashColor: ColorManager.lightPrimary,
    ),



    textTheme: TextTheme(
      //guest
      titleSmall: getRegularStyle(
          color: ColorManager.black,
          fontSize: FontSize.s24.sp
      ),
      //text butt
      titleMedium: getMediumStyle(
          color: ColorManager.black,
          fontSize: FontSize.s28.sp,
          fontFamily: "WorkSans",
          fontWeight: FontWeight.w600
      ),
      //title spinndo
      titleLarge: getBoldStyle(
        color: ColorManager.black,
        fontSize: FontSize.s54.sp,
      ),
      //text in body
      bodySmall: getRegularStyle(
          color: ColorManager.primary,
          fontSize: FontSize.s32.sp
      ),
      //client word
      bodyMedium: getMediumStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s36.sp,
      ),

      //elevated butt
      bodyLarge: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s32.sp,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(

      fillColor: ColorManager.primary,
      prefixIconColor: ColorManager.black,
      suffixIconColor: ColorManager.black,
      contentPadding: EdgeInsets.all(AppPadding.p8.sp),
      // hintStyle: getRegularStyle(
      //   color: ColorManager.grey,
      //   fontSize: FontSize.s13,
      // ),
      labelStyle: getThinStyle(
          color: ColorManager.black,
          fontSize: FontSize.s32.sp
      ),
      hintStyle:  getThinStyle(
          color: ColorManager.black,
          fontSize: FontSize.s32.sp
      ),
      errorStyle: getRegularStyle(
          color: Colors.red,
          fontSize: FontSize.s28.sp

      ),
      filled: true,

      enabledBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: ColorManager.grey2,
          width: AppSize.s1.w,
        ),
      ),
      focusedBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: ColorManager.grey2,
          width: AppSize.s1.w,
        ),
      ),
      errorBorder:  OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: Colors.red,
          width: AppSize.s1.w,
        ),
      ),     border:  OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
      borderSide: BorderSide(
        color: ColorManager.grey2,
        width: AppSize.s1.w,
      ),
    ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16.r)),
        borderSide: BorderSide(
          color: Colors.red,
          width: AppSize.s1.w,
        ),
      ),

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
