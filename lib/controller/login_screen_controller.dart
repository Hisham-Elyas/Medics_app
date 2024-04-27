import 'package:cuer_city/core/functions/coustom_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../data/model/user_model.dart';
import '../data/repositories/auth_repo.dart';

class LoginScreenController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey();
  late String email;
  late String password;
  final AuthRepoImpFirebase authRepo = Get.find();
  Future<void> submit() async {
    if (!loginFormKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    // print(email);
    // print(password);

    loginFormKey.currentState!.save();
    UserModel user = UserModel(email: email, password: password);
    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.logIn(userModel: user);
        if (isSuccess) {
          Get.offAllNamed(AppRoutes.getHomeScreen());
        }
      },
    );
  }

  bool goBack() {
    // print(previousRoute == '' ? true : false);
    // print(previousRoute == '/Login-Screen' ? true : false);
    // print(previousRoute);
    final previousRoute = Get.previousRoute;
    final String? goBack = Get.arguments;
    if (goBack != null) {
      return false;
    } else if (previousRoute == '/Start-Screen') {
      return true;
    } else if (previousRoute != '') {
      return false;
    }
    return true;
  }

  bool isShowPass = true;
  showPassword() {
    isShowPass = !isShowPass;
    update();
    Future.delayed(const Duration(seconds: 2), () {
      isShowPass = !isShowPass;
      update();
    });
  }

  set setEmail(val) {
    email = val;
  }

  set setPassword(val) {
    password = val;
  }

  bool isvalidEmail = false;
  bool isvalidpassword = false;
  String? emailvalidator(val) {
    isvalidEmail = false;
    update();
    if (val.isEmpty) {
      return "Type your email adress";
    } else if (!GetUtils.isEmail(val)) {
      return "Type in a valid email adress";
    } else {
      isvalidEmail = true;
      update();
      return null;
    }
  }

  String? passwordvalidator(val) {
    isvalidpassword = false;
    update();
    if (val.isEmpty) {
      return "Type your password";
    } else if (val.length < 6) {
      return "Password can not be less than six characters";
    } else {
      isvalidpassword = true;
      update();

      return null;
    }
  }
}
