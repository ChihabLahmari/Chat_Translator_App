import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/font_manager.dart';
import 'package:chat_translator/presentation/components/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.whiteGrey,
    scaffoldBackgroundColor: ColorManager.white,

    // ICON :
    iconTheme: IconThemeData(
      color: ColorManager.orange,
      size: AppSize.s25.sp,
    ),

    // APP BAR :
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: Colors.transparent,
      iconTheme: IconThemeData(color: ColorManager.orange),
      titleTextStyle: getlargeStyle(color: ColorManager.orange),
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.red,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),

    // BUTTON :
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.orange,
      splashColor: ColorManager.whiteOrange,
    ),

    // ELEVATED BUTTON  :
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getMeduimStyle(
          color: ColorManager.whiteGrey,
          fontSize: FontSize.s16.sp,
        ),
        backgroundColor: ColorManager.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10.sp),
        ),
      ),
    ),

    // INPUT DECORATION :
    inputDecorationTheme: InputDecorationTheme(
      // icon color
      iconColor: ColorManager.orange,

      // content padding
      contentPadding: EdgeInsets.all(AppPadding.p8.sp),

      // hint style
      hintStyle: getMeduimStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      // label style
      labelStyle: getMeduimStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      // error style
      errorStyle: getMeduimStyle(color: ColorManager.red, fontSize: FontSize.s14),

      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5.sp),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.sp)),
      ),

      // focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.orange, width: AppSize.s1_5.sp),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.sp)),
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5.sp),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.sp)),
      ),

      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5.sp),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.sp)),
      ),
    ),
  );
}

ThemeData getApplicationDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.whiteGrey,
    scaffoldBackgroundColor: ColorManager.white,

    // ICON :
    iconTheme: IconThemeData(
      color: ColorManager.orange,
      size: AppSize.s25.sp,
    ),

    // APP BAR :
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: Colors.transparent,
      iconTheme: IconThemeData(color: ColorManager.orange),
      titleTextStyle: getlargeStyle(color: ColorManager.orange),
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.red,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),

    // BUTTON :
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.orange,
      splashColor: ColorManager.whiteOrange,
    ),

    // ELEVATED BUTTON  :
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getMeduimStyle(
          color: ColorManager.whiteGrey,
          fontSize: FontSize.s16.sp,
        ),
        backgroundColor: ColorManager.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10.sp),
        ),
      ),
    ),

    // INPUT DECORATION :
    inputDecorationTheme: InputDecorationTheme(
      // icon color
      iconColor: ColorManager.orange,

      // content padding
      contentPadding: EdgeInsets.all(AppPadding.p8.sp),

      // hint style
      hintStyle: getMeduimStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      // label style
      labelStyle: getMeduimStyle(color: ColorManager.grey, fontSize: FontSize.s14),

      // error style
      errorStyle: getMeduimStyle(color: ColorManager.red, fontSize: FontSize.s14),

      // enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5.sp),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.sp)),
      ),

      // focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.orange, width: AppSize.s1_5.sp),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.sp)),
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5.sp),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.sp)),
      ),

      // focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5.sp),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8.sp)),
      ),
    ),
  );
}
