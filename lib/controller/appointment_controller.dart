import 'dart:developer';

import 'package:cuer_city/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../core/constant/app_color.dart';
import '../core/constant/string.dart';
import '../core/error/exception.dart';
import '../data/model/apointment_model.dart';
import '../data/model/doctor_model.dart';
import '../data/repositories/appointment_repo.dart';
import '../view/widget/custom_text_form_field.dart';
import 'package:jiffy/jiffy.dart';

class ApointmentController extends GetxController {
  late StatusRequest statusReq;

  @override
  void onInit() async {
    super.onInit();
    await getAllAppointment();
  }

  Future<void> getAllAppointment() async {
    statusReq = StatusRequest.loading;
    update();
    final data = await appointmentRepo.getAllAppointment();
    data.fold((l) {
      statusReq = l;

      update();
    }, (r) {
      /////
      _appointmentlist.clear();
      // final h = r.appointment
      //     .where((element) => element.bookDate!.day >= DateTime.now().day);
      _appointmentlist.addAll(r.appointment);
      _appointmentlist.sort(
        (a, b) => a.bookDate!.compareTo(b.bookDate!),
      );
      // print("=======hhh=======");
      // print(Jiffy.parse(_appointmentlist[5].bookDate).fromNow());
      // print(_appointmentlist[5].bookDate);

      // _appointmentlist.sort((a, b) {

      // Jiffy.parse(a.createdAt!).toUtc() >  Jiffy.parse(b.createdAt!).toNow();

      // }  );
      statusReq = StatusRequest.success;

      update();
    });
  }

  final List taps = [
    'Upcoming',
    'Completed',
    'Canceled',
  ];
  String? _userName;
  int tapLIstNum = 0;

  set setTapLIstNum(val) {
    tapLIstNum = val;
    update();
  }

  late DateTime bookingDate;
  final GlobalKey<FormState> bookingformKey = GlobalKey();
  final List<Appointment> _appointmentlist = [];
  List<Appointment> get appointlist {
    _appointmentlist.sort(
      (a, b) => a.bookDate!.compareTo(b.bookDate!),
    );
    return _appointmentlist;
  }

  final AppointmentRepoImpHttp appointmentRepo = Get.find();

  set setuserName(val) => _userName = val;
  get getuserName => _userName;

  List<Appointment> filterAppointmentlist(int index) {
    List<Appointment> newlist = [];
    for (var el in _appointmentlist) {
      if (index == 0) {
        if (!el.isCompleted! &&
            el.bookDate!
                .isAfter(DateTime.now().add(const Duration(days: -1)))) {
          //fix add month chack
          newlist.add(el);
        }
      } else if (index == 1) {
        if (el.isCompleted!) {
          newlist.add(el);
        }
      }
    }
    if (index == 2) {
      // fix add from local
      newlist.addAll(getCacheCanceledAppoint());
    }

    return newlist;
  }

  String? userNamevalidator(String? val) {
    if (val!.isEmpty) {
      return "Type your Name";
    } else if (GetUtils.isUsername(val)) {
      return "Enter your vlied name";
    } else {
      setuserName = val;
      if (oldAppointment != null) {
        oldAppointment = oldAppointment!.copyWith(name: val);
      }
      return null;
    }
  }

  Appointment? oldAppointment;
  void bookApointment({
    required Doctor doctorinfo,
    required bool isNew,
  }) {
    showDatePicker(
      context: Get.context!,
      initialDate: isNew ? DateTime.now() : oldAppointment!.bookDate!,
      firstDate: DateTime(2000),
      // firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
      currentDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      bookingDate = date;
      // final formatDate =
      //     Jiffy.parseFromDateTime(bookingDate).format(pattern: 'E, d MMM yyyy');
      showBokingDialog(
        isNew: isNew,
        bookingDate: bookingDate,
        doctorinfo: doctorinfo,
        oldAppoint: oldAppointment,
      );
    });
  }

  void showBokingDialog(
      {required bookingDate,
      required Doctor doctorinfo,
      Appointment? oldAppoint,
      required bool isNew}) {
    oldAppointment = oldAppoint;
    bookingDate = bookingDate;
    Get.defaultDialog(
      title: 'Book Appointment',
      barrierDismissible: false,
      titlePadding: EdgeInsets.only(top: 20.h),
      contentPadding: EdgeInsets.all(20.h),
      buttonColor: AppColor.mainColor,
      radius: 30.r,
      titleStyle: TextStyle(
        color: AppColor.fontColor3,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      content: BokingDialog(
        isNew: isNew,
        date: bookingDate,
        doctorinfo: doctorinfo,
      ),
      // onConfirm: () => submitApointment(doctorinfo),
      // onCancel: () {},
    );
  }

  bool isAdding = false;
  Future<void> submitApointment({
    required Doctor doctorinfo,
    required bool isNew,
  }) async {
    if (!bookingformKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    bookingformKey.currentState!.save();
    Get.focusScope!.unfocus();

    // final fromDate =
    //     Jiffy.parseFromDateTime(bookingDate).format(pattern: 'E, d/M/yyyy');

    //////////////// ****
    isAdding = true;
    update();
    final bool isSucss;

    if (isNew) {
      isSucss = await appointmentRepo.addAppointment(
          appointment: Appointment(
        userId: 'H1',
        bookDate: bookingDate,
        doctor: doctorinfo,
        name: _userName!,
      ));
    } else {
      // print("===========>  updated");
      isSucss = await appointmentRepo.updateAppointment(
          appointment: oldAppointment!
              .copyWith(bookDate: bookingDate, name: _userName!));
      _userName = null;
    }

    if (isSucss) {
      getAllAppointment();
      isAdding = false;
      Get.close(1);
      update();
    } else {
      isAdding = false;
      update();
    }
  }

  bool isCanceling = false;

  void cancelApointment({required Appointment appointment}) async {
    log(_appointmentlist.length.toString());
    isCanceling = true;
    update();
    final bool isCanceled =
        await appointmentRepo.deleteAppointment(appointmentId: appointment.id);
    if (isCanceled) {
      cacheCanceledAppoint(appointment: appointment);
      _appointmentlist.removeWhere((element) => element.id == appointment.id);
      appointmentRepo.appointmentLocalData.cachegetAppointment(
          key: 'APPOINTMENT_CACHE',
          appointment: AppointmentModel(
              count: _appointmentlist.length, appointment: _appointmentlist));
      if (_appointmentlist.isEmpty) {
        statusReq = StatusRequest.noData;
      }
      isCanceling = false;
      update();
      log(" count ====>   ${_appointmentlist.length}");
      log(" isCanceled ====>   $isCanceled");
    } else {
      isCanceling = false;
      update();
    }
  }

  void cacheCanceledAppoint({required Appointment appointment}) {
    List<Appointment> cancledAppoint = [];
    try {
      cancledAppoint = appointmentRepo.appointmentLocalData
          .getCachedAppointmentModel(
            key: 'CANCELED_APPOINTMENT_CACHE',
          )
          .appointment;
      print("..........................");
    } on EmptyCacheException {}
    cancledAppoint.add(appointment);
    appointmentRepo.appointmentLocalData.cachegetAppointment(
      appointment: AppointmentModel(
          count: cancledAppoint.length, appointment: cancledAppoint),
      key: 'CANCELED_APPOINTMENT_CACHE',
    );
  }

  List<Appointment> getCacheCanceledAppoint() {
    try {
      final cancledAppoint = appointmentRepo.appointmentLocalData
          .getCachedAppointmentModel(
            key: 'CANCELED_APPOINTMENT_CACHE',
          )
          .appointment;
      return cancledAppoint;
    } on EmptyCacheException {
      return [];
    }
  }
}

class BokingDialog extends GetView<ApointmentController> {
  final DateTime date;
  final Doctor doctorinfo;
  final bool isNew;

  const BokingDialog({
    super.key,
    required this.isNew,
    required this.doctorinfo,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Form(
        key: controller.bookingformKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              // autofocus: true,
              initialValue: isNew
                  ? controller.getuserName ?? ''
                  : controller.oldAppointment?.name ?? '',
              hintText: Enter_your_name.tr,
              prefixIconImg: ImageAssetPNG.userIcons,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              isvalid: true,
              validator: (val) => controller.userNamevalidator(val),
              onSaved: (val) => controller.setuserName = val,
            ),
            SizedBox(height: 15.h),
            Text('Date',
                style: TextStyle(
                  color: AppColor.fontColor1,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                )),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  ImageAssetSVG.circleCalendarIcon,
                  height: 40.h,
                  width: 40.w,
                ),
                SizedBox(width: 10.w),
                Text(
                    Jiffy.parseFromDateTime(date)
                        .format(pattern: 'E, d MMM yyyy'),
                    style: TextStyle(
                      color: AppColor.fontColor1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    )),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Get.back();
                    controller.bookApointment(
                      isNew: isNew,
                      doctorinfo: doctorinfo,
                    );
                  },
                  child: Text('Change',
                      style: TextStyle(
                        color: AppColor.fontColor2,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      )),
                )
              ],
            ),
            GetBuilder<ApointmentController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: controller.isAdding
                          ? null
                          : () {
                              controller.setuserName = null;
                              Get.close(1);
                            },
                      child: Text("Cancel",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          )),
                      style: ButtonStyle(
                          side: MaterialStatePropertyAll(BorderSide(
                              width: 2, color: AppColor.mainColor)))),
                  ElevatedButton(
                    onPressed: controller.isAdding
                        ? null
                        : () => controller.submitApointment(
                              doctorinfo: doctorinfo,
                              isNew: isNew,
                            ),
                    child: controller.isAdding
                        ? SizedBox(
                            height: 25.h,
                            width: 25.w,
                            child: CircularProgressIndicator(strokeWidth: 3.w),
                          )
                        : Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
