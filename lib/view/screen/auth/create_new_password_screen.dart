import 'package:cuer_city/core/constant/app_color.dart';
import 'package:cuer_city/view/widget/custom_text_form_field.dart';
import 'package:cuer_city/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/forgot_password_controller.dart';
import '../../../core/constant/image_asset.dart';
import '../../../core/constant/string.dart';
import '../../widget/custom_button.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h).copyWith(top: 34.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(Create_New_Password.tr,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 26.sp,
                  color: AppColor.fontColor1,
                  fontWeight: FontWeight.bold)),
          Text(Create_your_new_password_to_login.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.fontColor2,
              )),
          SizedBox(height: 24.h),
          GetBuilder<ResstPasswordController>(
            builder: (resstPasswordcontroller) => Form(
                key: resstPasswordcontroller.formKeyPass,
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: Enter_your_password.tr,
                      prefixIconImg: ImageAssetPNG.passwordIcons,
                      suffixIconImg: resstPasswordcontroller.isShowPass
                          ? ImageAssetPNG.eyeSlashIcons
                          : ImageAssetPNG.showpassIcons,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: resstPasswordcontroller.isShowPass,
                      isvalid: resstPasswordcontroller.isvalidpassword,
                      validator: (val) =>
                          resstPasswordcontroller.passwordvalidator(val, 1),
                      onSaved: (val) =>
                          resstPasswordcontroller.setpasswordOne = val,
                      onsuffixIconTap: () =>
                          resstPasswordcontroller.showPassword(),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      hintText: Enter_your_password.tr,
                      prefixIconImg: ImageAssetPNG.passwordIcons,
                      suffixIconImg: resstPasswordcontroller.isShowPass
                          ? ImageAssetPNG.eyeSlashIcons
                          : ImageAssetPNG.showpassIcons,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: resstPasswordcontroller.isShowPass,
                      isvalid: resstPasswordcontroller.isvalidpassword,
                      validator: (val) =>
                          resstPasswordcontroller.passwordvalidator(val, 2),
                      onSaved: (val) =>
                          resstPasswordcontroller.setPasswordTow = val,
                      onsuffixIconTap: () =>
                          resstPasswordcontroller.showPassword(),
                    ),
                    SizedBox(height: 24.h),
                    CustomButton(
                      text: Create_Password.tr,
                      width: 327.w,
                      height: 56.h,
                      onPressed: () {
                        resstPasswordcontroller.submitPass();
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
                        //               'Success',
                        //               style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 20.sp,
                        //                 color: AppColor.fontColor1,
                        //               ),
                        //             ),
                        //             SizedBox(height: 8.h),
                        //             Text(
                        //               'You have successfully reset your password.',
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
                  ],
                )),
          ),
        ]),
      ),
    );
  }
}
