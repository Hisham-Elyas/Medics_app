import 'dart:convert';

import '../../../core/class/api_client.dart';
import '../../../core/error/exception.dart';
import '../../model/hospital_model.dart';

abstract class HospitalRemotdata {
  Future<HospitalModelList> getAllHospital();
}

class HospitalRemotDataImpHttp implements HospitalRemotdata {
  final ApiClent apiClent;

  HospitalRemotDataImpHttp({required this.apiClent});
  final url = 'http://10.0.2.2:3000';

  @override
  Future<HospitalModelList> getAllHospital() async {
    final resalt = await apiClent.getData(uri: '$url/Hospitals');
    if (resalt.statusCode == 200) {
      return HospitalModelList.fromJson(jsonEncode(resalt.body));
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
