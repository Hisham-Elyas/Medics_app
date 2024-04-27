import 'package:cuer_city/core/constant/app_color.dart';
import 'package:cuer_city/core/constant/image_asset.dart';
import 'package:cuer_city/core/constant/routes.dart';
import 'package:cuer_city/data/model/doctor_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/appointment_controller.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/expandable_text.dart';

class DoctorDetailScrren extends GetView<ApointmentController> {
  final Doctor doctorinfo;

  const DoctorDetailScrren({required this.doctorinfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Doctor Detail',
        //  actions: [
        //   Container(
        //     margin: EdgeInsets.only(right: 20.w),
        //     height: 30.h,
        //     width: 30.w,
        //     child: InkWell(
        //       borderRadius: BorderRadius.circular(8.r),
        //       onTap: () {
        //         Get.toNamed(AppRoutes.getDrugsCartScreen());
        //       },
        //       child: SvgPicture.asset(
        //         ImageAssetSVG.buyIconW,
        //         fit: BoxFit.none,
        //         height: 24.h,
        //         width: 24.w,
        //       ),
        //     ),
        // ),
        // ]
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 33.h),
        FittedBox(
          child: SizedBox(
            // padding: EdgeInsets.symmetric(horizontal: 20),
            height: 121.h,
            width: 334.w,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 115,
                width: 115,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    'assets/images/pexels-cedric-fauntleroy-4270371.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 17.w),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${doctorinfo.name}',
                    style: TextStyle(
                        color: AppColor.fontColor1,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${doctorinfo.specialty}',
                    style: TextStyle(
                        color: AppColor.fontColor2,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 14.w),
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
                        '${doctorinfo.address}',
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
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'About',
            style: TextStyle(
                color: AppColor.fontColor1,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
        Divider(
          color: AppColor.mainColor2,
          endIndent: 20.w,
          indent: 20.w,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandableText(
                    text: '${doctorinfo.description}',
                  ),

                  // SizedBox(height: 30.h),
                  // SizedBox(
                  //   height: 64.h,
                  //   // width: MediaQuery.of(context).size.width,
                  //   child: ListView.separated(
                  //     separatorBuilder: (context, index) => SizedBox(width: 12.w),
                  //     itemCount: 7,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) => Container(
                  //       height: 64.h,
                  //       width: 46.w,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15.r),
                  //           border:
                  //               Border.all(color: AppColor.mainColor2, width: 1.w)),
                  //       child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text(
                  //               'Mon',
                  //               style: TextStyle(
                  //                   color: AppColor.fontColor2,
                  //                   fontSize: 10.sp,
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //             Text(
                  //               '${index + 1}',
                  //               style: TextStyle(
                  //                   color: AppColor.fontColor1,
                  //                   fontSize: 18.sp,
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //           ]),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),

        Divider(
          color: AppColor.mainColor2,
          endIndent: 20.w,
          indent: 20.w,
        ),
        // Spacer()
        // SizedBox(height: 100.h),

        // SizedBox(height: 30.h),
        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 20.w),
        //     child: GridView.builder(
        //       itemCount: 9,
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3,
        //         crossAxisSpacing: 13.w,
        //         mainAxisExtent: 37.h,
        //         mainAxisSpacing: 15.h,
        //       ),
        //       itemBuilder: (context, index) => Container(
        //         width: 103,
        //         height: 37,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(15.r),
        //             border:
        //                 Border.all(color: AppColor.mainColor2, width: 1.w)),
        //         child: Center(
        //           child: Text(
        //             '${index + 1}:00 AM',
        //             style: TextStyle(
        //                 color: AppColor.fontColor1,
        //                 fontSize: 12.sp,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(10.r),
              onTap: () {
                Get.toNamed(AppRoutes.getChatsScreenScreen(doctorinfo));
              },
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColor.mainColor2),
                child: SvgPicture.asset(
                  ImageAssetSVG.chatIcon,
                  // color: AppColor.mainColor,
                  fit: BoxFit.none,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                controller.bookApointment(doctorinfo: doctorinfo, isNew: true);
              },
              text: 'Book Appointment',
              height: 50.h,
              width: 266.w,
            ),
          ],
        ),
      ),
    );
  }
}
