import 'package:get/get.dart';

getdeviceLocale({required en, required ar}) {
  String deviceLocale = Get.deviceLocale!.languageCode;
  if (deviceLocale == "en") {
    return en;
  } else if (deviceLocale == "ar") {
    return ar;
  } else {
    return en;
  }
}
