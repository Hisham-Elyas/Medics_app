import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/app_color.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final bool isOutlin;
  final double? height;
  final double? width;
  final String? text;
  const CustomButton(
      {super.key,
      this.onPressed,
      this.text,
      this.child,
      this.isOutlin = false,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(isOutlin
              ? AppColor.mainColor.withOpacity(0.4)
              : AppColor.mainColor3.withOpacity(0.6)),
          backgroundColor: MaterialStatePropertyAll(
              isOutlin ? AppColor.backgroundColor : AppColor.mainColor),
          elevation: MaterialStatePropertyAll(isOutlin ? 1 : 5),
          enableFeedback: true,
          padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
      onPressed: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          //     color: isOutlin ? AppColor.backgroundColor : AppColor.mainColor,
          borderRadius: BorderRadius.circular(32.r),
          border:
              isOutlin ? Border.all(width: 2, color: AppColor.mainColor) : null,
        ),
        child: Center(
            child: text == null
                ? child
                : Text(
                    text!,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isOutlin
                            ? AppColor.mainColor
                            : AppColor.backgroundColor),
                  )),
      ),
    );
  }
}
