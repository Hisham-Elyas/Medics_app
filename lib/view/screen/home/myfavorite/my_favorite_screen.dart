import 'package:cuer_city/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/drugs_controller.dart';

import '../../../../core/constant/app_color.dart';
import '../../../widget/custom_app_bar.dart';
import '../drugs/drugs_detail_screen.dart';
import '../drugs/widget/cart_widget.dart';

class MyFavoriteScreen extends GetView<DrugsController> {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final DrugsController controller = Get.find();
    // Get.put(DrugsController(), permanent: true);

    // final h = controller.favoriteDrug.values.toList().length;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(title: 'My Saved ', goBack: true, actions: [
          Container(
            padding: EdgeInsets.only(right: 20.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () {
                controller.deleteAllFav();
              },
              child: Row(
                children: [
                  Text(
                    'Clear',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: AppColor.mainColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SvgPicture.asset(
                    ImageAssetSVG.deleteIcon,
                    fit: BoxFit.none,
                  ),
                ],
              ),
            ),
          ),
        ]),
        body: Container(
          // width: 200,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 33.h),
          child: Column(children: [
            // Expanded(child: Center(child: Text('ggggggggggggggggggggg'))),
            // Expanded(child: Center(child: Text(h.length.toString()))),
            Expanded(
              child: GetBuilder<DrugsController>(
                // init: DrugsController(),
                builder: (controller) => ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 20.h),
                    itemCount: controller.favoriteDrug.length,
                    itemBuilder: (context, index) {
                      final drigsData = controller.favoriteDrug.values.toList();

                      return CartWidget(
                        onTap: () {
                          Get.to(
                            () => DrugsDetailScrren(product: drigsData[index]),
                          );
                        },
                        onTapIcon: () {
                          controller.addTofavorite(drigsData[index]);
                        },
                        drigs: drigsData[index],
                        buttomIcon: ImageAssetSVG.deleteIcon,
                      );
                    }),
              ),
            )
          ]),
        )
        //   bottomNavigationBar: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Column(
        //           mainAxisSize: MainAxisSize.min,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               'Total',
        //               style: TextStyle(
        //                 fontSize: 14.sp,
        //                 color: AppColor.fontColor3,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //             const Text(
        //               '\$9.99',
        //               style: TextStyle(
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.bold,
        //                   color: AppColor.fontColor1),
        //             ),
        //           ],
        //         ),
        //         CustomButton(
        //           onPressed: () {},
        //           text: 'Checkout',
        //           height: 50.h,
        //           // width: 192.w,
        //           width: 200.w,
        //         ),
        //       ],
        //     ),
        //   ),
        );
  }
}
