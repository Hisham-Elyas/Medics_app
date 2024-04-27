import 'package:cuer_city/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // height: double.maxFinite,
      // width: MediaQuery.of(context).size.width,
      // color: AppColor.mainColor3,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xff52D1C6),
          Color(0xff30ADA2),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )),
      child: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            // height: 300.h,
            width: MediaQuery.of(context).size.width,
            // color: AppColor.mainColor3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor: AppColor.backgroundColor,
                  child: SvgPicture.asset(
                    ImageAssetSVG.logo2,
                    fit: BoxFit.scaleDown,
                    height: 60.h,
                    width: 60.w,
                  ),
                ),
                SizedBox(height: 19.h),
                Text(
                  'Hisahm Alyas',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.backgroundColor),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 31.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              color: AppColor.backgroundColor,
            ),
            // height: 380.h,
            // width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomProfileButton(
                    title: 'My Saved',
                    imageAssetSVG: ImageAssetSVG.heartIcon,
                    onTap: () {
                      Get.toNamed(AppRoutes.getFavoriteScreen());
                    },
                  ),
                  CustomProfileButton(
                    title: 'Appointmnet',
                    imageAssetSVG: ImageAssetSVG.documentIcon,
                    onTap: () {},
                  ),
                  CustomProfileButton(
                    title: 'Payment Method',
                    imageAssetSVG: ImageAssetSVG.walletIcon,
                    onTap: () {},
                  ),
                  CustomProfileButton(
                    title: 'FAQs',
                    imageAssetSVG: ImageAssetSVG.chatIcon,
                    onTap: () {},
                  ),
                  CustomProfileButton(
                    title: 'Logout',
                    colorTitle: AppColor.fontColor5,
                    isLast: true,
                    imageAssetSVG: ImageAssetSVG.dangerCircleIcon,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class CustomProfileButton extends StatelessWidget {
  final String title;
  final String imageAssetSVG;
  final void Function()? onTap;
  final Color? colorTitle;
  final bool isLast;
  const CustomProfileButton({
    super.key,
    required this.title,
    required this.imageAssetSVG,
    this.onTap,
    this.colorTitle = AppColor.fontColor1,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.red,
      focusColor: Colors.red,
      splashColor: Colors.red,
      hoverColor: Colors.red,
      overlayColor: MaterialStatePropertyAll(Colors.red),
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 43.h,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: AppColor.mainColor2,
                  child: SvgPicture.asset(
                    imageAssetSVG,
                    fit: BoxFit.none,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: colorTitle),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          isLast
              ? Container()
              : Column(
                  children: [
                    SizedBox(height: 13.h),
                    Divider(
                      endIndent: 10.w,
                      indent: 10.w,
                      color: AppColor.mainColor2,
                    ),
                    SizedBox(height: 13.h),
                  ],
                )
        ],
      ),
    );
  }
}
