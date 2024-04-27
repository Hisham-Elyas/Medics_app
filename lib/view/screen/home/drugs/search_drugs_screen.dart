import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/drugs_controller.dart';
import '../../../../core/constant/image_asset.dart';
import 'drugs_detail_screen.dart';
import 'widget/cart_widget.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.focusScope!.unfocus();
          Get.close(1);
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchWidget(query: query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchWidget(query: query);
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.query,
  });

  final String query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GetBuilder<DrugsController>(builder: (controller) {
        final drigsData = controller.filter(query);

        return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemCount: drigsData.isEmpty
                ? 1
                : drigsData.length > 25
                    ? 25
                    : drigsData.length,
            itemBuilder: (context, index) {
              // final drigsData = controller.drigsData2!.product!;
              return drigsData.isEmpty
                  ? const Center(child: Text('No Match'))
                  : CartWidget(
                      onTapIcon: () {
                        controller.addToCart(drigsData[index]);
                      },
                      onTap: () {
                        Get.focusScope!.unfocus();

                        Get.to(
                          () => DrugsDetailScrren(product: drigsData[index]),
                        );
                      },
                      drigs: drigsData[index],
                      buttomIcon: ImageAssetSVG.addIcon,
                    );
            });
      }),
    );
  }
}
