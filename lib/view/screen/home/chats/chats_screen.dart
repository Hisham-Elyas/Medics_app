import 'package:cuer_city/controller/chats_controller.dart';
import 'package:cuer_city/core/constant/app_color.dart';
import 'package:cuer_city/core/constant/image_asset.dart';
import 'package:cuer_city/view/widget/custom_button.dart';
import 'package:cuer_city/view/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:cuer_city/data/model/doctor_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../widget/custom_app_bar.dart';

class ChatsScreen extends StatefulWidget {
  final Doctor doctor;
  ChatsScreen({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final controller = TextEditingController();
  var h = "h1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,

      // bottomSheet: Container(
      //     color: Colors.red, height: 500, width: 500, child: Text('data')),
      appBar: CustomAppBar(
        title: 'Dr. ${widget.doctor.name}',
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: 25.w,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {},
              child: SvgPicture.asset(
                ImageAssetSVG.phoneIcon,
                width: 25.w,
                height: 25.h,
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<ChatsController>(builder: (controller) {
        return Column(children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: controller.msList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: index % 2 == 0
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Container(
                      // width: 230,
                      // controller.msList[index].length > 25 ? 230 : null,
                      margin: EdgeInsets.all(8.w).copyWith(
                        left: index % 2 == 0 ? 15.w : 120.w,
                        right: index % 2 == 0 ? 120.w : 15.w,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? AppColor.mainColor2
                              : AppColor.mainColor,
                          borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15.r))
                              .copyWith(
                            topLeft:
                                index % 2 == 0 ? null : Radius.circular(15.r),
                            topRight:
                                index % 2 == 0 ? Radius.circular(15.r) : null,
                          )),
                      child: Text(controller.msList.reversed.toList()[index],
                          style: TextStyle(
                              color: index % 2 == 0
                                  ? AppColor.fontColor6
                                  : Colors.white)),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.h),
            padding: EdgeInsets.all(8.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // height: 60.h,
                    // width: 207.w,
                    decoration: BoxDecoration(
                        color: AppColor.mainColor2,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: CustomTextFormField(
                      hintText: 'Type message ...',
                      // fillColor: AppColor.mainColor2,
                      controller: controller.textEditingCont,
                      onChanged: controller.setMassages,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                CustomButton(
                  child: const Icon(Icons.send, color: Colors.white),
                  // text: "Send",
                  // width: 111.w,
                  height: 60.h,
                  onPressed: controller.massages.isEmpty
                      ? null
                      : controller.sendMassages,
                )
              ],
            ),
          ),
        ]);
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) => StatefulBuilder(
      //         builder: (context, setState) => AlertDialog(
      //           content: Column(
      //             children: [
      //               Text(h),
      //               ElevatedButton(
      //                   onPressed: () {
      //                     setState(() {
      //                       h = "qqqqqq1111";
      //                     });
      //                   },
      //                   child: Text("data"))
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
