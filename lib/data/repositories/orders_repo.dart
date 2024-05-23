import 'dart:developer';

import 'package:get/get.dart';

import '../../core/constant/string.dart';
import '../../core/error/exception.dart';
import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_coustom_snackbar.dart';
import '../../core/functions/show_errormessage.dart';
import '../dataSoureces/remoteDataSource/orders_remotdata.dart';
import '../model/order_model.dart';

abstract class OrdersRepo {
  Future<bool> addOrder({required OrderModel order});
}

class OrderRepoImpHttp implements OrdersRepo {
  final OrderRemotDataImpHttp orderRemotData;

  OrderRepoImpHttp({required this.orderRemotData});

  @override
  Future<bool> addOrder({required OrderModel order}) async {
    if (await ckeckInternet()) {
      try {
        await orderRemotData.postOrder(body: order.toJson());

        log('to Server  ==> addOrder Data   ');
        showCustomSnackBar(message: "order addd", title: Done.tr);
        return true;
      } on ServerException catch (e) {
        showErrorMessage(e.message);

        return false;
      }
    } else {
      showNetworkError();
      return false;
    }
  }
}
