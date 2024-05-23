import 'package:feedback/feedback.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/services.dart';
import '../constant/app_theme.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  late ThemeData appTheme;
  ThemeMode themeMode = ThemeMode.system;
  FeedbackThemeData feedbackTheme = FeedbackThemeData.light();
  void changLang({required String langCode}) {
    Locale locale = Locale(langCode);
    language = Locale(langCode);
    // save in shard ...
    myServices.sharedPreferences.setString("lang", langCode);
    if (isDarkMode()) {
      appTheme = langCode == "en" ? AppTheme.darkEnglish : AppTheme.darkArabic;
    } else {
      appTheme =
          langCode == "en" ? AppTheme.lightEnglish : AppTheme.lightArabic;
    }
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
    update();
  }

  FeedbackThemeData getFeedbackThemeMode() {
    return isDarkMode() ? FeedbackThemeData.dark() : FeedbackThemeData.light();
  }

  void changeTheme() {
    String? sharedlang = myServices.sharedPreferences.getString("lang");
    if (Get.isDarkMode) {
      if (sharedlang == "ar") {
        Get.changeTheme(AppTheme.lightArabic);
      } else {
        Get.changeTheme(AppTheme.lightEnglish);
      }
    } else {
      if (sharedlang == "ar") {
        Get.changeTheme(AppTheme.darkArabic);
      } else {
        Get.changeTheme(AppTheme.darkEnglish);
      }

      // save in shard ...
    }
    myServices.sharedPreferences.setBool("isDarkMode", !Get.isDarkMode);
    feedbackTheme = getFeedbackThemeMode();
    update();
  }

  bool isDarkMode() {
    return myServices.sharedPreferences.getBool("isDarkMode") ?? false;
  }

  @override
  void onInit() {
    String? sharedlang = myServices.sharedPreferences.getString("lang");

    if (sharedlang == "en") {
      language = const Locale("en");
      if (isDarkMode()) {
        feedbackTheme = FeedbackThemeData.dark();
        appTheme = AppTheme.darkEnglish;
      } else {
        appTheme = AppTheme.lightEnglish;
        feedbackTheme = FeedbackThemeData.light();
      }
    } else if (sharedlang == "ar") {
      language = const Locale("ar");
      if (isDarkMode()) {
        feedbackTheme = FeedbackThemeData.dark();
        appTheme = AppTheme.darkArabic;
      } else {
        feedbackTheme = FeedbackThemeData.light();
        appTheme = AppTheme.lightArabic;
      }
    } else {
      String deviceLocale = Get.deviceLocale!.languageCode;
      language = Locale(deviceLocale);
      appTheme =
          deviceLocale == "en" ? AppTheme.lightEnglish : AppTheme.lightArabic;
    }

    Get.changeTheme(appTheme);

    super.onInit();
  }
}
