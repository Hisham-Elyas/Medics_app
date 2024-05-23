import 'dart:convert';

import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/functions/coustom_overlay.dart';
import '../core/services/services.dart';
import '../data/model/user_model.dart';
import '../data/repositories/auth_repo.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final MyServices services = Get.find();
    final userdata = services.sharedPreferences.getString('user_info');

    userInf = UserModel.fromMap(jsonDecode(userdata!));
  }

  late UserModel userInf;

  final AuthRepoImpFirebase authRepo = Get.find();

  logeOut() async {
    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.logeOut();
        if (isSuccess) {
          await Future.delayed(Duration.zero);
          Get.offAllNamed(AppRoutes.getOnBoardingn());
        }
      },
    );
  }
}
