import 'dart:convert';

import '../../../core/class/api_client.dart';
import '../../../core/error/exception.dart';
import '../../model/order_model.dart';

abstract class OrderRemotData {
  Future<bool> postOrder({required body});
  Future<List<OrderModel>> getOrder({required userId});
  Future<bool> cancelOrder({required orderId});
}

class OrderRemotDataImpHttp implements OrderRemotData {
  final ApiClent apiClent;

  OrderRemotDataImpHttp({required this.apiClent});
  final url = 'http://10.0.2.2:3000';

  @override
  Future<bool> postOrder({required body}) async {
    final resalt = await apiClent.posData(uri: '$url/Orders', body: body);
    if (resalt.statusCode == 201) {
      return true;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<List<OrderModel>> getOrder({required userId}) async {
    final resalt = await apiClent.getData(uri: '$url/orders/$userId');
    if (resalt.statusCode == 200) {
      return OrderListModel.fromJson(jsonEncode(resalt.body)).producus;
    } else {
      // log("==============> ${resalt.statusCode}");
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> cancelOrder({required orderId}) async {
    final resalt =
        await apiClent.updateData(uri: '$url/orders/$orderId', body: {});
    if (resalt.statusCode == 200) {
      return true;
    } else {
      // log("==============> ${resalt.statusCode}");
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
