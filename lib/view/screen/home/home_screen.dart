import 'package:cuer_city/core/constant/app_color.dart';
import 'package:cuer_city/core/constant/image_asset.dart';
import 'package:cuer_city/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/static_data.dart';
import '../../widget/category_wdget.dart';
import 'drugs/search_drugs_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(title: 'home', goBack: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              // Center(
              //     child: ElevatedButton(
              //   onPressed: () async {
              //     final MyServices h = Get.find();
              //     await h.firebaseAuth.signOut();
              //     Get.offAllNamed(AppRoutes.getOnBoardingn());
              //   },
              //   child: const Text('signOut'),
              // )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find your desire \nhealt solution',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.fontColor1),
                  ),
                  InkWell(
                      onTap: () async {
                        drugslistF();
                        // final MyServices h = Get.find();
                        // await h.firebaseAuth.signOut();
                        // Get.offAllNamed(AppRoutes.getOnBoardingn());
                      },
                      child: SvgPicture.asset(ImageAssetSVG.notificationLogo)),
                ],
              ),
              SizedBox(height: 20.h),
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
                      'Search doctor, drugs, articles...',
                      style: TextStyle(
                          color: AppColor.fontColor4, fontSize: 12.sp),
                    ),
                  ]),
                ),
              ),
              SizedBox(height: 20.h),

              // SizedBox(height: 12.h),
              Expanded(
                // height: 90.h,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: categoryHomeList.length,
                  itemBuilder: (context, index) => CategoryWidget(
                    img: categoryHomeList[index].img,
                    name: categoryHomeList[index].name,
                    onTap: () {
                      switch (categoryHomeList[index].name) {
                        case 'Doctor':
                          Get.toNamed(AppRoutes.getDoctorsScreen());

                          break;
                        case 'Pharmacy':
                          Get.toNamed(AppRoutes.getDrugsScrren());

                          break;
                        case 'Hospital':
                          // Get.toNamed(AppRoutes.getDrugsScrren());

                          break;
                        case 'Ambulance':
                          // Get.toNamed(AppRoutes.getDrugsScrren());

                          break;
                        default:
                      }
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
