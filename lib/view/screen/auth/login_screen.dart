import 'package:cuer_city/controller/login_screen_controller.dart';
import 'package:cuer_city/core/constant/app_color.dart';
import 'package:cuer_city/core/constant/routes.dart';
import 'package:cuer_city/view/widget/custom_text_form_field.dart';
import 'package:cuer_city/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/string.dart';
import '../../widget/custom_app_bar.dart';
import 'widget/sign_in_with.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: LOGIN.tr,
          goBack: controller.goBack(),
          // goBack: false,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 40.h),
              // width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GetBuilder<LoginScreenController>(
                      builder: (logincontroller) => Form(
                            key: logincontroller.loginFormKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  hintText: Enter_your_email.tr,
                                  prefixIconImg: ImageAssetPNG.emailIcons,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  isvalid: logincontroller.isvalidEmail,
                                  validator: (val) =>
                                      logincontroller.emailvalidator(val),
                                  onSaved: (val) =>
                                      logincontroller.setEmail = val,
                                ),
                                SizedBox(height: 16.h),
                                CustomTextFormField(
                                  hintText: Enter_your_password.tr,
                                  prefixIconImg: ImageAssetPNG.passwordIcons,
                                  suffixIconImg: logincontroller.isShowPass
                                      ? ImageAssetPNG.eyeSlashIcons
                                      : ImageAssetPNG.showpassIcons,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: logincontroller.isShowPass,
                                  isvalid: logincontroller.isvalidpassword,
                                  validator: (val) =>
                                      logincontroller.passwordvalidator(val),
                                  onSaved: (val) =>
                                      logincontroller.setPassword = val,
                                  onsuffixIconTap: () =>
                                      logincontroller.showPassword(),
                                ),
                              ],
                            ),
                          )),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () =>
                            Get.toNamed(AppRoutes.getResetPasswordScreen()),
                        child: Text(
                          Forgot_Password.tr,
                        )),
                  ),
                  CustomButton(
                    text: LOGIN.tr,
                    width: 327.w,
                    height: 56.h,
                    onPressed: () {
                      controller.submit();
                      // Get.defaultDialog(
                      //   backgroundColor: AppColor.backgroundColor,
                      //   title: '',
                      //   content: Center(
                      //     child: Container(
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 21.w, vertical: 32.h),
                      //       width: 327.w,
                      //       height: 401.h,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(24.r),
                      //         color: AppColor.backgroundColor,
                      //       ),
                      //       child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             SvgPicture.asset(
                      //               'assets/svg/Done.svg',
                      //               height: 102.h,
                      //               width: 102.w,
                      //             ),
                      //             SizedBox(height: 32.h),
                      //             Text(
                      //               'Yeay! Welcome Back',
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 20.sp,
                      //                 color: AppColor.fontColor1,
                      //               ),
                      //             ),
                      //             SizedBox(height: 8.h),
                      //             Text(
                      //               'Once again you login successfully into medidoc app',
                      //               textAlign: TextAlign.center,
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.bold,
                      //                   color: AppColor.fontColor2,
                      //                   fontSize: 16.sp),
                      //             ),
                      //             SizedBox(height: 32.h),
                      //             CustomButton(
                      //               text: 'Go to home',
                      //               width: 183.w,
                      //               height: 56.h,
                      //               onPressed: () =>
                      //                   Get.toNamed(AppRoutes.getHomeScreen()),
                      //             )
                      //           ]),
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  // Expanded(
                  //   child: Container(),
                  // ),
                  // SizedBox(height: 43.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Dont_have_an_account.tr,
                        style: TextStyle(
                            color: AppColor.fontColor3, fontSize: 15.sp),
                      ),
                      TextButton(
                        onPressed: () =>
                            Get.offAllNamed(AppRoutes.getSignUpScreen()),
                        child: Text(
                          Sign_Up.tr,
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 43.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(endIndent: 15.w),
                      ),
                      Text(
                        OR.tr,
                        style: TextStyle(
                            color: AppColor.fontColor2, fontSize: 16.sp),
                      ),
                      Expanded(
                          child: Divider(
                        indent: 15.w,
                      )),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  SignInWith(
                    imgSvg: ImageAssetSVG.googleLogo,
                    text: Sign_in_with_Google.tr,
                    onTap: () {
                      Get.offAllNamed(AppRoutes.getHomeScreen());
                    },
                  ),
                  SizedBox(height: 16.h),
                  SignInWith(
                    imgSvg: ImageAssetSVG.appleLogo,
                    text: Sign_in_with_Apple.tr,
                    onTap: () {},
                  ),
                  SizedBox(height: 16.h),
                  SignInWith(
                    imgSvg: ImageAssetSVG.facebookLogo,
                    text: Sign_in_with_Facebook.tr,
                    onTap: () {},
                  ),
                ],
              )),
        ));
  }
}
