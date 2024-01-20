import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize.sp,
    color: color,
    fontWeight: fontWeight,
    overflow: TextOverflow.ellipsis,
  );
}

// small style
TextStyle getSmallStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// Meduim Style
TextStyle getMeduimStyle({
  double fontSize = FontSize.s16,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// large style
TextStyle getRegularStyle({
  double fontSize = FontSize.s20,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

TextStyle getlargeStyle({
  double fontSize = FontSize.s25,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
