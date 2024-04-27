import 'package:cuer_city/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/static_data.dart';
import '../../../widget/category_wdget.dart';
import '../../../widget/custom_app_bar.dart';
import '../drugs/search_drugs_screen.dart';

class DoctorsScrren extends StatelessWidget {
  const DoctorsScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Doctors',
        //  actions: [
        // Container(
        //   margin: EdgeInsets.only(right: 20.w),
        //   height: 30.h,
        //   width: 30.w,
        //   child: InkWell(
        //     borderRadius: BorderRadius.circular(8.r),
        //     onTap: () {
        //       Get.toNamed(AppRoutes.getDrugsCartScreen());
        //     },
        //     child: SvgPicture.asset(
        //       ImageAssetSVG.buyIconW,
        //       fit: BoxFit.none,
        //       height: 24.h,
        //       width: 24.w,
        //     ),
        //   ),
        // ),
        // ]
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Container(
                // width: 324.w,
                height: 40,
                padding: EdgeInsets.only(left: 17.w),
                decoration: BoxDecoration(
                  color: const Color(0xffFBFBFB),
                  borderRadius: BorderRadius.circular(24.r),
                  border:
                      Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(24.r),
                  onTap: () {
                    // Get.toNamed(AppRoutes.getDrugsSearchScreen());
                    showSearch(context: context, delegate: Search());
                  },
                  child: Row(children: [
                    SvgPicture.asset(ImageAssetSVG.searchLogo),
                    SizedBox(width: 12.h),
                    Text(
                      'Find a doctor...',
                      style: TextStyle(
                          color: AppColor.fontColor4, fontSize: 12.sp),
                    ),
                  ]),
                ),
              ),
              SizedBox(height: 30.h),
              Text('Category',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColor.fontColor1,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 18.h),
              Expanded(
                // height: 90.h,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: categoryDoctorList.length,
                  itemBuilder: (context, index) => CategoryWidget(
                    // img: 'assets/svg/Covid.svg',
                    img: categoryDoctorList[index].img,
                    name: categoryDoctorList[index].name,
                    onTap: () {
                      Get.toNamed(AppRoutes.getDoctorListScreen(
                          categoryDoctorList[index].name));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
