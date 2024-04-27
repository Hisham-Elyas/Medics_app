import 'package:cuer_city/core/class/handling_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/doctor_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../widget/custom_app_bar.dart';
import '../drugs/search_drugs_screen.dart';

class DoctorListScreen extends StatelessWidget {
  final String category;

  const DoctorListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '$category Doctors', actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          height: 30.h,
          width: 30.w,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              showSearch(context: context, delegate: Search());
            },
            child: SvgPicture.asset(
              ImageAssetSVG.searchLogo,
              fit: BoxFit.none,
              color: AppColor.mainColor,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
      ]),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Expanded(
                child: GetBuilder<DoctorController>(builder: (controller) {
                  final doctors = controller.filterDoctors(category);
                  return HandlingDataView(
                      statusReq: controller.statusReq,
                      onPressedReload: controller.getAllDoctors,
                      widget: RefreshIndicator(
                        onRefresh: controller.getAllDoctors,
                        child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 13.h),
                            itemCount: doctors.length,
                            itemBuilder: (context, index) => DoctorWidget(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.getDoctorDetailScrren(
                                        doctors[index]!));
                                  },
                                  img: doctors[index]?.img ?? '',
                                  name: doctors[index]?.name ?? '',
                                  address: doctors[index]?.address ?? '',
                                  category: doctors[index]?.specialty ?? '',
                                )),
                      ));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorWidget extends StatelessWidget {
  final String img;
  final String name;
  final String category;
  final String address;
  final void Function() onTap;
  const DoctorWidget({
    Key? key,
    required this.img,
    required this.name,
    required this.category,
    required this.address,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      splashColor: AppColor.mainColor2,
      highlightColor: AppColor.mainColor3,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
        ),
        height: 130.h,
        width: 334.w,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 111.h,
            width: 111.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                'assets/images/pexels-cedric-fauntleroy-4270371.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 18.w),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    color: AppColor.fontColor1,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                category,
                style: TextStyle(
                    color: AppColor.fontColor2,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15.w),
              Container(
                  height: 18.h,
                  width: 41.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: AppColor.mainColor2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        ImageAssetSVG.starIcon,
                        // color: AppColor.mainColor,
                        fit: BoxFit.none,
                        height: 13.h,
                        width: 13.w,
                      ),
                      // Icon(
                      //   Icons.star,
                      //   size: 13.h,
                      //   color: AppColor.mainColor,
                      // ),
                      Text(
                        '4,7',
                        style: TextStyle(
                            color: AppColor.mainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
              SizedBox(height: 12.h),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssetSVG.locationIcon,
                    // color: AppColor.mainColor,
                    fit: BoxFit.none,
                    height: 13.h,
                    width: 13.w,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    address,
                    style: TextStyle(
                        color: AppColor.fontColor2,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
