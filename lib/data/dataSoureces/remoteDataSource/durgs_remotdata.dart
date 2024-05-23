import '../../../core/class/api_client.dart';
import '../../../core/error/exception.dart';
import '../../model/drugs_model.dart';
import '../../model/drugs_model/product.dart';

abstract class DrugsRemotData {
  getAllData();
  getRandData({required int limet});
  Future<Product> findById({required String id});
  Future<DrugsModel> searchByName({required String name});
}

class DrugsRemotDataImpHttp implements DrugsRemotData {
  final ApiClent apiClent;
  DrugsRemotDataImpHttp({required this.apiClent});
  final url = 'http://10.0.2.2:3000';
  @override
  Future<DrugsModel> getAllData() async {
    final resalt = await apiClent.getData(uri: '$url /drugs');
    if (resalt.statusCode == 200) {
      return DrugsModel.fromJson(resalt.body);
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<DrugsModel> getRandData({required int limet}) async {
    final resalt = await apiClent.getData(uri: '$url /drugs/randpro/$limet');

    if (resalt.statusCode == 200) {
      return DrugsModel.fromJson(resalt.body);
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<Product> findById({required String id}) async {
    final resalt = await apiClent.getData(uri: '$url /drugs/$id');

    if (resalt.statusCode == 200) {
      return Product.fromJson(resalt.body['product']);
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<DrugsModel> searchByName({required String name}) async {
    final resalt = await apiClent.getData(uri: '$url/drugs/search/$name');
    if (resalt.statusCode == 200) {
      return DrugsModel.fromJson(resalt.body);
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
