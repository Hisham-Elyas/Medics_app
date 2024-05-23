import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignInWith extends StatelessWidget {
  final String imgSvg;
  final String text;
  final void Function()? onTap;
  const SignInWith({
    super.key,
    required this.imgSvg,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(width: 1.w, color: const Color(0xffE5E7EB)),
      ),
      height: 56.h,
      width: 372.w,
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 18.w,
              ),
              child: SvgPicture.asset(
                imgSvg,
                height: 20.h,
                width: 19.58.w,
              ),
            ),

            SizedBox(width: 54.32.w),
            Center(
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
            ),
            // SizedBox(width: 89.w),
          ],
        ),
      ),
    );
  }
}
