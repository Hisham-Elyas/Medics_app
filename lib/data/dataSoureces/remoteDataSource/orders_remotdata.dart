import '../../../core/class/api_client.dart';
import '../../../core/error/exception.dart';

abstract class OrderRemotData {
  Future<bool> postOrder({required body});
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
}
