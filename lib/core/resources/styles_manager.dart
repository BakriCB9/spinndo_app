import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle getTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required Color color,
  String fontFamily = FontConstants.fontFamily,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
    color: color,
  );
}

TextStyle getThinStyle({
  double fontSize = FontSize.s24,
  String fontFamily = FontConstants.fontFamily,
  required Color color,
}) {
  return getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: FontWeightManager.thin,
    color: color,
  );
}

TextStyle getRegularStyle({
  double fontSize = FontSize.s24,
  String fontFamily = FontConstants.fontFamily,
  FontWeight fontWeight = FontWeightManager.regular,
  required Color color,
}) {
  return getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle getMediumStyle({
  double fontSize = FontSize.s24,
  String fontFamily = FontConstants.fontFamily,
  FontWeight fontWeight = FontWeightManager.regular,
  required Color color,
}) {
  return getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle getSemiBoldStyle({
  String fontFamily = FontConstants.fontFamily,
  double fontSize = FontSize.s28,
  required Color color,
}) {
  return getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: FontWeightManager.semiBold,
    color: color,
  );
}

TextStyle getBoldStyle({
  String fontFamily = FontConstants.fontFamily,
  double fontSize = FontSize.s24,
  required Color color,
}) {
  return getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: FontWeightManager.bold,
    color: color,
  );
}
