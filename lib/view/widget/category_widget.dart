import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/app_color.dart';

class CategoryWidget extends StatelessWidget {
  final String name;
  final String img;
  final void Function()? onTap;
  const CategoryWidget({
    super.key,
    required this.name,
    required this.img,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64.w,
      height: 84.h,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Material(
          borderRadius: BorderRadius.circular(16.r),
          elevation: 3,
          shadowColor: AppColor.mainColor3,
          child: Container(
            width: 64.w,
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Theme.of(context).colorScheme.background,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              splashColor: AppColor.mainColor,
              onTap: onTap,
              child: SvgPicture.asset(
                img,
                fit: BoxFit.scaleDown,
                height: 32.h,
                width: 32.w,
              ),
            ),
          ),
        ),
        FittedBox(
          child: Text(
            name,
            style: TextStyle(
                color: AppColor.fontColor2,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
