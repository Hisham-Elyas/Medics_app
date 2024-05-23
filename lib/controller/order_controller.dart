import 'dart:convert';

import 'package:cuer_city/core/services/services.dart';
import 'package:get/get.dart';

import '../data/model/location_model.dart';
import '../data/model/order_model.dart';
import '../data/repositories/orders_repo.dart';
import 'drugs_controller.dart';
import 'user_controller.dart';

class OrderController extends GetxController {
  final OrderRepoImpHttp orderRepoImpHttp = Get.find();
  UserController userInfoController = Get.find();
  DrugsController drugsController = Get.find();
  MyServices serv = Get.find();
  List<OrderModel> cartHistory = [];
  final List<String> taps = [
    "Pending",
    "History",
  ];
  int tapLIstNum = 0;

  set setTapLIstNum(val) {
    tapLIstNum = val;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getCartHistoryList();
  }

  void ordering({required LocationModel location}) async {
    final OrderModel newOrder = OrderModel(
      userInfo: userInfoController.userInf,
      userLocation: location,
      listProduct: drugsController.cartDrigs,
    );

    /// send newOrder to Server
    final bool isOk = await orderRepoImpHttp.addOrder(order: newOrder);
    if (isOk) {
      cartHistory.add(newOrder);
      await addToCartHistoryList(orderList: cartHistory);
      // drugsController.deleteAllCart();
      Get.close(1);
    }
  }

  Future<void> addToCartHistoryList(
      {required List<OrderModel> orderList}) async {
    await serv.sharedPreferences
        .setString("CART_HISTORY_LIST", jsonEncode(orderList));
  }

  void getCartHistoryList() {
    final cachedCartHistory =
        serv.sharedPreferences.getString("CART_HISTORY_LIST");
    if (cachedCartHistory != null) {
      final List cart = jsonDecode(cachedCartHistory);
      cartHistory = cart.map((e) => OrderModel.fromJson(e)).toList();
    }
  }

  void clearCartHistory() {
    serv.sharedPreferences.remove("CART_HISTORY_LIST");
  }
}
