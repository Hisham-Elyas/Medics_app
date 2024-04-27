import 'package:cuer_city/core/constant/app_color.dart';
import 'package:cuer_city/view/widget/custom_text_form_field.dart';
import 'package:cuer_city/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/sign_up_screen_controller.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/routes.dart';
import '../../../core/constant/string.dart';
import '../../widget/custom_app_bar.dart';

class SignUpScreen extends GetView<SignUpScreenController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: Sign_Up, goBack: false),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 43.h),
              width: MediaQuery.of(context).size.width,
              child: GetBuilder<SignUpScreenController>(
                builder: (signUpcontroller) => Column(
                  children: [
                    Form(
                      key: signUpcontroller.signUpformKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: Enter_your_name.tr,
                            prefixIconImg: ImageAssetPNG.userIcons,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            isvalid: signUpcontroller.isvalidUserName,
                            validator: (val) =>
                                signUpcontroller.userNamevalidator(val),
                            onSaved: (val) =>
                                signUpcontroller.setuserName = val,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            hintText: Enter_your_email.tr,
                            prefixIconImg: ImageAssetPNG.emailIcons,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            isvalid: signUpcontroller.isvalidEmail,
                            validator: (val) =>
                                signUpcontroller.emailvalidator(val),
                            onSaved: (val) => signUpcontroller.setEmail = val,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            hintText: Enter_your_password.tr,
                            prefixIconImg: ImageAssetPNG.passwordIcons,
                            suffixIconImg: signUpcontroller.isShowPass
                                ? ImageAssetPNG.eyeSlashIcons
                                : ImageAssetPNG.showpassIcons,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: signUpcontroller.isShowPass,
                            isvalid: signUpcontroller.isvalidpassword,
                            validator: (val) =>
                                signUpcontroller.passwordvalidator(val),
                            onSaved: (val) =>
                                signUpcontroller.setPassword = val,
                            onsuffixIconTap: () =>
                                signUpcontroller.showPassword(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Checkbox(
                          side: const BorderSide(color: Color(0xffE5E7EB)),
                          shape: const BeveledRectangleBorder(
                            side: BorderSide(
                              width: 1.5,
                            ),
                          ),
                          value: true,
                          onChanged: (value) {},
                        ),
                        Text(
                          I_agree_to_the_medidoc_Terms_of_Service_and_Privacy_Policy
                              .tr,
                          style: TextStyle(
                              fontSize: 13.sp, color: AppColor.fontColor1),
                        ),
                      ],
                    ),
                    SizedBox(height: 48.h),
                    CustomButton(
                      text: LOGIN.tr,
                      width: 327.w,
                      height: 56.h,
                      onPressed: () {
                        controller.submit();
                        // Get.defaultDialog(
                        //   backgroundColor: AppColor.backgroundColor,
                        //   title: '',
                        //   content: Container(
                        //     padding: EdgeInsets.symmetric(
                        //       horizontal: 21.w,
                        //       // vertical: 32.h,
                        //     ),
                        //     width: 327.w,
                        //     height: 401.h,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(24.r),
                        //       // color: AppColor.backgroundColor,
                        //     ),
                        //     child: Center(
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
                        //               'Success',
                        //               style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 20.sp,
                        //                 color: AppColor.fontColor1,
                        //               ),
                        //             ),
                        //             SizedBox(height: 8.h),
                        //             Text(
                        //               'Your account has been successfully registered',
                        //               textAlign: TextAlign.center,
                        //               style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   color: AppColor.fontColor2,
                        //                   fontSize: 16.sp),
                        //             ),
                        //             SizedBox(height: 32.h),
                        //             CustomButton(
                        //               text: 'Login',
                        //               width: 183.w,
                        //               height: 56.h,
                        //             )
                        //           ]),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                    SizedBox(height: 24.h),
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
                              Get.offAllNamed(AppRoutes.getLoginScreen()),
                          child: Text(
                            Sign_In.tr,
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }
}
