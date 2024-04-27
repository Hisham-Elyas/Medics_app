import 'package:cuer_city/core/services/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/constant/static_data.dart';

class OnBordingController extends GetxController {
  int currentPage = 0;
  MyServices myServices = Get.find();
  late final PageController myPageController = PageController();
  nextPage() {
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      // debugPrint('object');
      myServices.sharedPreferences.setBool('OnBording', true);
      Get.toNamed(AppRoutes.getStartScreen());
    } else {
      myPageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  skip() {
    Get.toNamed(AppRoutes.getStartScreen());
  }

  onPageChanged(int value) {
    currentPage = value;
    update();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   myPageController = PageController();
  // }
}
