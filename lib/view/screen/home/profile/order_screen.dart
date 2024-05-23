import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/order_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../widget/custom_app_bar.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Orders'),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            const CustomTapWidget(),
            SizedBox(height: 30.h),
            Expanded(
              child: ListView.separated(
                  itemCount: controller.cartHistory.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) => InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      splashColor: Theme.of(context).colorScheme.secondary,
                      highlightColor: AppColor.mainColor3,
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 7.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.r),
                          border: Border.all(
                              width: 1.w, color: const Color(0xffE8F3F1)),
                        ),
                        height: 130.h,
                        width: 334.w,
                        child:
                            Text(controller.cartHistory[index].userInfo.email),
                      ))),
            )
          ],
        ),
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
    return GetBuilder<OrderController>(
      builder: (controller) => Container(
        width: 335.w,
        height: 46.h,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
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
              child: Text(controller.taps[index].tr,
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
