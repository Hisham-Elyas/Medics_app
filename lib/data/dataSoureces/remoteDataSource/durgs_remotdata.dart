import 'package:cuer_city/core/error/exception.dart';

import '../../../core/class/api_client.dart';
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
    //192.168.3.227
    // try {
    final resalt = await apiClent.getData(uri: '$url /drugs');
    if (resalt.statusCode == 200) {
      return DrugsModel.fromJson(resalt.body);
    } else {
      // left(ServerFailure());
      // print(resalt.statusCode);
      // print(resalt.statusText);
      throw ServerException(message: "${resalt.statusCode}");

      // throw Exception();
    }
    // } catch (e) {
    //   left(ServerFailure());
    // }
  }

  @override
  Future<DrugsModel> getRandData({required int limet}) async {
    final resalt = await apiClent.getData(uri: '$url /drugs/randpro/$limet');

    // print(resalt.body);
    if (resalt.statusCode == 200) {
      return DrugsModel.fromJson(resalt.body);
    } else {
      // left(ServerFailure());
      // print(resalt.statusCode);
      // print(resalt.statusText);
      throw ServerException(message: "${resalt.statusCode}");

      // throw Exception();
    }
  }

  @override
  Future<Product> findById({required String id}) async {
    final resalt = await apiClent.getData(uri: '$url /drugs/$id');
    // print(resalt.body['product']);
    if (resalt.statusCode == 200) {
      return Product.fromJson(resalt.body['product']);
    } else {
      // left(ServerFailure());
      // print(resalt.statusCode);
      // print(resalt.statusText);
      throw ServerException(message: "${resalt.statusCode}");
      // throw Exception();
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
