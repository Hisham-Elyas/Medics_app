// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:cuer_city/controller/appointment_controller.dart';
import 'package:cuer_city/core/constant/app_color.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../data/model/apointment_model.dart';

class ScheduleScreen extends GetView<ApointmentController> {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.getAllAppointment();
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: AppColor.backgroundColor.withOpacity(0.1),
        // backgroundColor: AppColor.backgroundColor.withOpacity(0.1),
        scrolledUnderElevation: 0,
        // forceMaterialTransparency: false,
        // automaticallyImplyLeading: false,
        // elevation: 0,
        // bottomOpacity: 0,
        // shadowColor: AppColor.backgroundColor.withOpacity(0.1),
        title: Text('Schedule',
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.fontColor1)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: InkWell(
                borderRadius: BorderRadius.circular(24.r),
                onTap: () {},
                child: SvgPicture.asset(ImageAssetSVG.notificationLogo)),
          ),
        ],
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(children: [
          CustomTapWidget(),
          SizedBox(height: 30.h),
          GetBuilder<ApointmentController>(builder: (controller) {
            final data =
                controller.filterAppointmentlist(controller.tapLIstNum);
            // final data = controller.appointlist.reversed.toList();
            return HandlingDataView(
              buttonTextEmpty: 'Add Appointment',
              statusReq: controller.statusReq,
              onPressedTextButtom: () {},
              onPressedReload: () => controller.getAllAppointment(),
              widget: Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    return controller.getAllAppointment();
                  },
                  child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemBuilder: (context, index) => ScheduleWidget(
                            appointment: data[index],
                            onTapCancel: controller.isCanceling
                                ? null
                                : () {
                                    controller.cancelApointment(
                                        appointment: data[index]);
                                  },
                            onTapReschedule: () {
                              controller.showBokingDialog(
                                isNew: false,
                                oldAppoint: data[index],
                                bookingDate: data[index].bookDate,
                                doctorinfo: data[index].doctor,
                              );
                            },
                          )),
                ),
              ),
            );
            // ? Center(child: CircularProgressIndicator())
          })
        ]),
      ),
    );
  }
}

class CustomTapWidget extends StatelessWidget {
  const CustomTapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApointmentController>(
      builder: (controller) => Container(
        width: 335.w,
        height: 46.h,
        decoration: BoxDecoration(
            color: AppColor.mainColor2,
            borderRadius: BorderRadius.circular(8.r)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.taps.length,
          itemBuilder: (context, index) => InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              controller.setTapLIstNum = index;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              alignment: Alignment.center,
              width: 335.w / controller.taps.length,
              height: 46.h,
              decoration: BoxDecoration(
                  color: index == controller.tapLIstNum
                      ? AppColor.mainColor
                      : null,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Text(controller.taps[index],
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: index == controller.tapLIstNum
                          ? AppColor.backgroundColor
                          : AppColor.fontColor1)),
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleWidget extends GetView<ApointmentController> {
  final Appointment appointment;
  final void Function()? onTapReschedule;
  final void Function()? onTapCancel;

  const ScheduleWidget({
    Key? key,
    required this.onTapReschedule,
    required this.onTapCancel,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 197.h,
      width: 335.w,
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
          border: Border.all(width: 1.5.w, color: AppColor.mainColor2),
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dr. ${appointment.doctor.name}',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.fontColor1)),
                  Text(appointment.doctor.specialty!,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.fontColor2))
                ],
              ),
              CircleAvatar(
                radius: 30.r,
                backgroundImage: const AssetImage(
                    'assets/images/pexels-cedric-fauntleroy-4270371.png'),
              )
            ],
          ), // Chardiologist
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                ImageAssetSVG.circleCalendarIcon,
                height: 30.h,
                width: 30.w,
              ),
              SizedBox(width: 10.w),
              Text(
                  Jiffy.parseFromDateTime(appointment.bookDate!)
                      .format(pattern: 'E, d/M/yyyy'),
                  style: TextStyle(
                    color: AppColor.fontColor1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(width: 50.w),
              Container(
                height: 8.h,
                width: 8.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: appointment.isConfirmed!
                      ? Color(0xfff7BEB78)
                      : Colors.grey,
                ),
              ),
              SizedBox(width: 5.w),
              Text(appointment.isConfirmed! ? 'Confirmed' : "Pending",
                  style: TextStyle(
                    color: AppColor.fontColor1,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          SizedBox(height: 15.h),
          if (controller.tapLIstNum != 2 &&
              !appointment.isCompleted! &&
              appointment.bookDate!
                  .isAfter(DateTime.now().add(const Duration(days: -1))))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  splashColor: AppColor.mainColor2,
                  highlightColor: AppColor.mainColor3,
                  onTap: onTapCancel,
                  child: Container(
                    alignment: Alignment.center,
                    width: 145.h,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColor.mainColor2.withOpacity(0.6),
                    ),
                    child: Text('Cancel',
                        style: TextStyle(
                          color: AppColor.fontColor1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  splashColor: AppColor.mainColor,
                  highlightColor: AppColor.mainColor,
                  onTap: onTapReschedule,
                  child: Container(
                    alignment: Alignment.center,
                    width: 145.h,
                    height: 46,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColor.mainColor.withOpacity(0.8)),
                    child: Text('Reschedule',
                        style: TextStyle(
                          color: AppColor.backgroundColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
