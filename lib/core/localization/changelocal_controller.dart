import '../../core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_theme.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  late ThemeData appTheme;

  changLang(String langCode) {
    Locale locale = Locale(langCode);
    // save in shard ...
    appTheme = langCode == "en" ? themeEnglish : themeArabic;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedlang;
    if (sharedlang == "en") {
      language = const Locale("en");
      appTheme = themeEnglish;
    } else if (sharedlang == "ar") {
      language = const Locale("ar");
      appTheme = themeArabic;
    } else {
      String deviceLocale = Get.deviceLocale!.languageCode;
      language = Locale(deviceLocale);
      appTheme = deviceLocale == "en" ? themeEnglish : themeArabic;

      // print(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
