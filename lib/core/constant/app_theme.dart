import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData themeEnglish = ThemeData(
  // fontFamily: 'Cairo',
  // textTheme: TextTheme(

  // ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: AppColor.backgroundColor,
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor)
      .copyWith(background: AppColor.backgroundColor),
);

ThemeData themeArabic = ThemeData(
  fontFamily: 'Cairo',
  // textTheme: TextTheme(

  // ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: AppColor.backgroundColor,
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor)
      .copyWith(background: AppColor.backgroundColor),
);
