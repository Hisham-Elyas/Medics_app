import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/routes.dart';
import '../core/functions/coustom_overlay.dart';
import '../data/repositories/auth_repo.dart';

class ResstPasswordController extends GetxController {
  late final GlobalKey<FormState> formKeyEmail = GlobalKey();
  late final GlobalKey<FormState> formKeyPass = GlobalKey();
  final AuthRepoImpFirebase authRepo = Get.find();

  late String email;
  late String codeVerify;
  late String passwordOne;
  late String passwordTow;

  Future<void> reSetPassword() async {
    if (!formKeyEmail.currentState!.validate()) {
      // Invalid!
      return;
    }
    formKeyEmail.currentState!.save();

    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.reSetPassword(email: email);
        if (isSuccess) {
          Get.toNamed(AppRoutes.getVerifyCodeScreen());
        }
      },
    );
    // Get.toNamed(AppRoutes.getVerifyCodeScreen());
    // print(passwordOne);
    // print(email);
    // print(passwordTow);
  }

  Future<void> submitVerifyCode() async {
    print(codeVerify);
    // return;
    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.verifyCode(code: codeVerify);
        if (isSuccess) {
          Get.toNamed(AppRoutes.getCreateNewPasswordScreen());
        }
      },
    );
    // Get.toNamed(AppRoutes.getCreateNewPasswordScreen());
  }

  Future<void> reSendVerifyCode() async {
    showOverlay(
      asyncFunction: () async {
        await authRepo.reSendVerifyCode(email: email);
      },
    );
  }

  Future<void> submitPass() async {
    if (!formKeyPass.currentState!.validate()) {
      // Invalid!
      return;
    }
    formKeyPass.currentState!.save();

    showOverlay(
      asyncFunction: () async {
        final bool isSuccess = await authRepo.setNewPassword(
            code: codeVerify, newPassword: passwordTow);
        if (isSuccess) {
          Get.offAllNamed(AppRoutes.getHomeScreen());
        }
      },
    );
    // Get.toNamed(AppRoutes.getHomeScreen());ss

    // print(passwordOne);
    // print(passwordTow);
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

  set setPasswordTow(val) {
    passwordTow = val;
  }

  set setpasswordOne(val) {
    passwordOne = val;
  }

  bool isvalidEmail = false;
  bool isvalidpasswordOne = false;
  bool isvalidpassword = false;

  String? emailvalidator(val) {
    isvalidEmail = false;
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

  String? passwordvalidator(val, number) {
    isvalidpassword = false;
    if (val.isEmpty) {
      return "Type your password";
    } else if (val.length < 6) {
      return "Password can not be less than six characters";
    } else {
      if (number == 2 && val != passwordOne) {
        return "Password not match";
      } else {
        passwordOne = val;
        isvalidpassword = true;
        update();

        return null;
      }
    }
  }
}
