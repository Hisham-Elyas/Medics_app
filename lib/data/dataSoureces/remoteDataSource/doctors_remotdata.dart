import 'dart:convert';

import '../../../core/class/api_client.dart';
import '../../../core/error/exception.dart';
import '../../model/doctor_model.dart';

abstract class DoctorsRemotData {
  Future<DoctorModel> getAllDoctors();

  // findDoctor();
}

class DoctorsRemotDataImpHttp implements DoctorsRemotData {
  final ApiClent apiClent;

  DoctorsRemotDataImpHttp({required this.apiClent});
  final url = 'http://10.0.2.2:3000';

  @override
  Future<DoctorModel> getAllDoctors() async {
    final resalt = await apiClent.getData(uri: '$url/doctor');
    if (resalt.statusCode == 200) {
      return DoctorModel.fromJson(jsonEncode(resalt.body));
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
