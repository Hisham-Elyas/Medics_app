import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/class/handling_data_view.dart';
import 'core/constant/routes.dart';
import 'core/localization/changelocal_controller.dart';
import 'core/localization/translations.dart';
import 'core/services/services.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        locale: controller.language,
        translations: MyTranslations(),
        debugShowCheckedModeBanner: false,
        title: 'Cuer City',
        theme: controller.appTheme,
        // home: const OnBoarding(),
        // home: const HandlingDataView(),
        getPages: AppRoutes.myPages,
      ),
    );
  }
}
