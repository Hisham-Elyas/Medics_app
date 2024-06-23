import 'dart:convert';

import '../../../core/class/api_client.dart';
import '../../../core/error/exception.dart';
import '../../model/apointment_model.dart';

abstract class AppointmentRemotData {
  Future<AppointmentModel> getAllAppointment({required String userId});
  Future<bool> postAppointment({required body});
  Future<bool> updatreAppointment({required body, required appointmentId});
  Future<bool> deleteAppointment({required appointmentId});

  // findDoctor();
}

class AppointmentRemotDataImpHttp implements AppointmentRemotData {
  final ApiClent apiClent;

  AppointmentRemotDataImpHttp({required this.apiClent});
  final url = 'http://10.0.2.2:3000';

  @override
  Future<AppointmentModel> getAllAppointment({required String userId}) async {
    final resalt = await apiClent.getData(uri: '$url/appointment/$userId');
    if (resalt.statusCode == 200) {
      return AppointmentModel.fromJson(jsonEncode(resalt.body));
    } else {
      // log("==============> ${resalt.statusCode}");
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> postAppointment({required body}) async {
    final resalt = await apiClent.posData(uri: '$url/appointment', body: body);
    if (resalt.statusCode == 201) {
      return true;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> deleteAppointment({required appointmentId}) async {
    final resalt =
        await apiClent.deleteData(uri: '$url/appointment/$appointmentId');
    if (resalt.statusCode == 200) {
      return true;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }

  @override
  Future<bool> updatreAppointment(
      {required body, required appointmentId}) async {
    final resalt = await apiClent.updateData(
        uri: '$url/appointment/$appointmentId', body: body);
    if (resalt.statusCode == 200) {
      return true;
    } else {
      throw ServerException(message: "${resalt.statusCode}");
    }
  }
}
