import 'package:cuer_city/core/class/handling_data_view.dart';
import 'package:cuer_city/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/drugs_controller.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/image_asset.dart';
import '../../../../data/model/drugs_model/product.dart';
import '../../../widget/custom_app_bar.dart';
import 'drugs_detail_screen.dart';
import 'search_drugs_screen.dart';
import '../../../widget/product_widget.dart';

class DrugsScrren extends GetView<DrugsController> {
  const DrugsScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Pharmacy', actions: [
        Container(
          margin: EdgeInsetsDirectional.only(end: 20.w),
          height: 30.h,
          width: 30.w,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              Get.toNamed(AppRoutes.getDrugsCartScreen());
            },
            child: SvgPicture.asset(
              ImageAssetSVG.buyIconW,
              fit: BoxFit.none,
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
      ]),
      body: RefreshIndicator(
        onRefresh: controller.getAllDrougs,
        child: Column(children: [
          SizedBox(height: 33.h),
          //// search bar
          Container(
            // width: 324.w,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            height: 40,
            padding: EdgeInsetsDirectional.only(start: 17.w),
            decoration: BoxDecoration(
              color: const Color(0xffFBFBFB),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(width: 1.w, color: const Color(0xffE8F3F1)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(24.r),
              onTap: () {
                // Get.toNamed(AppRoutes.getDrugsSearchScreen());
                showSearch(context: context, delegate: Search());
              },
              child: Row(children: [
                SvgPicture.asset(ImageAssetSVG.searchLogo),
                SizedBox(width: 12.h),
                Text(
                  'Search drugs, category...',
                  style: TextStyle(color: AppColor.fontColor4, fontSize: 12.sp),
                ),
              ]),
            ),
          ),
          SizedBox(height: 25.h),

          /// Popular Product  + see All  row
          Container(
            // margin: EdgeInsetsDirectional.only(start: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular Product',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.fontColor1,
                      fontWeight: FontWeight.w500,
                    )),
                InkWell(
                  borderRadius: BorderRadius.circular(15.r),
                  onTap: () {
                    showSearch(context: context, delegate: Search());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.h),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(height: 28.h),

          GetBuilder<DrugsController>(builder: (drugsController) {
            // final List<Product>? drigsData = drugsController.drigsData2?.product;
            final List<Product> drigsData = drugsController.randDrugsList;
            final List<Product> favoriteDrug =
                drugsController.favoriteDrug.values.toList();
            return HandlingDataView(
                statusReq: drugsController.statusReq,
                onPressedReload: drugsController.getAllDrougs,
                widget: Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 20.w),
                        height: 170.h,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 15.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: drigsData.length,
                          itemBuilder: (context, index) => ProductWidget(
                            product: drigsData[index],
                            onTapAdd: () {
                              drugsController.addToCart(drigsData[index]);
                            },
                            onTap: () {
                              // drugsController.getalldata();
                              Get.to(
                                () => DrugsDetailScrren(
                                    product: drigsData[index]),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      // Spacer(),

                      /// fav Product  + see All  row
                      Container(
                        // margin: EdgeInsetsDirectional.only(start: 20.w),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Favorite Product',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColor.fontColor1,
                                  fontWeight: FontWeight.w500,
                                )),
                            InkWell(
                              borderRadius: BorderRadius.circular(15.r),
                              onTap: () => null,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.h),
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    color: AppColor.mainColor,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 28.h),
                      Container(
                        padding: EdgeInsetsDirectional.only(start: 20.w),
                        height: 170.h,
                        child: favoriteDrug.isEmpty
                            ? Center(
                                child: Text('add product to your fav'),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 15.w),
                                scrollDirection: Axis.horizontal,
                                itemCount: favoriteDrug.length,
                                itemBuilder: (context, index) => ProductWidget(
                                  product: favoriteDrug[index],
                                  onTapAdd: () {
                                    drugsController
                                        .addToCart(favoriteDrug[index]);
                                  },
                                  onTap: () {
                                    // drugsController.getalldata();
                                    Get.to(
                                      () => DrugsDetailScrren(
                                          product: favoriteDrug[index]),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ));
          }),
        ]),
      ),
    );
  }
}
