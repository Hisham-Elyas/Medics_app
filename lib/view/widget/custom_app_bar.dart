import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constant/app_color.dart';
import '../../core/functions/get_device_locale.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool goBack;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.goBack = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      bottomOpacity: 0,
      shadowColor: AppColor.backgroundColor.withOpacity(0.1),
      actions: actions,
      leading: goBack
          ? Padding(
              padding: const EdgeInsetsDirectional.only(start: 5),
              child: IconButton(
                alignment: Alignment.center,
                enableFeedback: true,
                onPressed: () => Get.back(),
                icon: Icon(getdeviceLocale(
                    en: Icons.arrow_back_ios_new,
                    ar: Icons.arrow_forward_ios_rounded)),
              ),
            )
          : null,
      title: Text(
        title ?? '',
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 44.h);
}
