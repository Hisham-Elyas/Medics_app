import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/location_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../core/constant/routes.dart';
import '../../../widget/custom_app_bar.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Address",
        actions: [
          Container(
              margin: EdgeInsetsDirectional.only(end: 20.w),
              decoration: BoxDecoration(
                  color: AppColor.mainColor3,
                  borderRadius: BorderRadius.circular(15.r)),
              child: IconButton(
                  color: AppColor.mainColor,
                  onPressed: () {
                    Get.toNamed(AppRoutes.getLocationScreen());
                  },
                  icon: const Icon(Icons.add))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
            height: 370,
            child: Column(
              children: [
                GetBuilder<LocationController>(
                  builder: (controller) => Expanded(
                    child: controller.myLocationlist.isEmpty
                        ? const Center(child: Text("Add location!"))
                        : ListView.builder(
                            itemCount: controller.myLocationlist.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 3,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  highlightColor: AppColor.mainColor,
                                  child: ListTile(
                                    title: Text(
                                      "${index + 1} - ${controller.myLocationlist[index].addressType}",
                                      style: const TextStyle(),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    leading: SvgPicture.asset(
                                        ImageAssetSVG.location2Icon),
                                    trailing: IconButton(
                                        color: const Color(0xffcf6679),
                                        onPressed: () {
                                          controller.deletLocation(index);
                                        },
                                        icon: const Icon(Icons.delete)),
                                    subtitle: Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        controller
                                            .myLocationlist[index].address),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
