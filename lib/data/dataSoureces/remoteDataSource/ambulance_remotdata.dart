import 'dart:convert';

import '../../../core/class/api_client.dart';
import '../../../core/error/exception.dart';
import '../../model/ambulance_model.dart';

abstract class AmbulanceRemotdata {
  Future<AmbulanceModelList> getAllAmbulance();
}

class AmbulanceRemotDataImpHttp implements AmbulanceRemotdata {
  final ApiClent apiClent;

  AmbulanceRemotDataImpHttp({required this.apiClent});
  final url = 'http://10.0.2.2:3000';

  @override
  Future<AmbulanceModelList> getAllAmbulance() async {
    final resalt = await apiClent.getData(uri: '$url/Ambulance');
    if (resalt.statusCode == 200) {
      return AmbulanceModelList.fromJson(jsonEncode(resalt.body));
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
