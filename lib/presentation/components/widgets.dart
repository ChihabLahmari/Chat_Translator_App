import 'package:chat_translator/presentation/components/appsize.dart';
import 'package:chat_translator/presentation/components/assets_manager.dart';
import 'package:chat_translator/presentation/components/color_manager.dart';
import 'package:chat_translator/presentation/components/styles_manager.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

Widget customFormField({
  required TextEditingController textEditingcontroller,
  required String textLabel,
  required String? errorLabel,
  required TextInputType textInputType,
  required Function(String) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        textLabel,
        style: getMeduimStyle(
          color: ColorManager.dark,
          fontSize: AppSize.s20,
        ),
        // textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: AppSize.s10,
      ),
      TextFormField(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          filled: true,
          fillColor: ColorManager.whiteGrey,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          errorText: errorLabel,
        ),
        controller: textEditingcontroller,
        style: getMeduimStyle(color: ColorManager.dark),
        keyboardType: textInputType,
        onChanged: onChanged,
      ),
    ],
  );
}

Widget customPasswordFormField({
  required TextEditingController textEditingcontroller,
  required String textLabel,
  required String? errorLabel,
  required TextInputType textInputType,
  required Function(String) onChanged,
  required Function() onVisibleChanged,
  required bool isPasswordVisible,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        textLabel,
        style: getMeduimStyle(
          color: ColorManager.dark,
          fontSize: AppSize.s20,
        ),
        // textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: AppSize.s10,
      ),
      TextFormField(
        obscureText: isPasswordVisible,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onVisibleChanged,
            icon: Icon(
              isPasswordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: ColorManager.dark,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          filled: true,
          fillColor: ColorManager.whiteGrey,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          errorText: errorLabel,
        ),
        controller: textEditingcontroller,
        style: getMeduimStyle(color: ColorManager.dark),
        keyboardType: textInputType,
        onChanged: onChanged,
      ),
    ],
  );
}

Widget customElevatodButton(String label, Function()? onPressed) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        if (onPressed != null)
          BoxShadow(
            color: ColorManager.orange.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 12,
            offset: const Offset(0, 0),
          ),
      ],
    ),
    child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppPadding.p20.sp,
            horizontal: AppPadding.p30.sp,
          ),
          child: Text(
            label.toUpperCase(),
            style: getRegularStyle(color: ColorManager.white),
          ),
        )),
  );
}

// Toasts ::

CherryToast errorToast(String msg) {
  return CherryToast.error(
    title: Text(msg, style: TextStyle(color: ColorManager.red)),
    backgroundColor: ColorManager.whiteGrey,
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}

CherryToast successToast(String msg) {
  return CherryToast.success(
    title: Text(msg, style: TextStyle(color: ColorManager.orange)),
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}

// Loading Screen ::

Container loadingScreen() {
  return Container(
    color: ColorManager.white,
    child: Center(
      child: SizedBox(
        height: AppSize.s200.sp,
        width: AppSize.s200.sp,
        child: Lottie.asset(LottieAsset.loading, fit: BoxFit.contain),
      ),
    ),
  );
}
