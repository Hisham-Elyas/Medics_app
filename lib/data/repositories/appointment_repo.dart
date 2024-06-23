import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../core/class/enums.dart';
import '../../core/constant/string.dart';
import '../../core/error/exception.dart';
import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_coustom_snackbar.dart';
import '../../core/functions/show_errormessage.dart';
import '../dataSoureces/localDataSource/appointment_localdata.dart';
import '../dataSoureces/remoteDataSource/appointment_remotdata.dart';
import '../model/apointment_model.dart';

abstract class AppointmentRepo {
  Future<Either<StatusRequest, AppointmentModel>> getAllAppointment(
      {required String userId});

  Future<bool> addAppointment({required Appointment appointment});
  Future<bool> updateAppointment({required Appointment appointment});
  Future<bool> deleteAppointment({required appointmentId});
}

class AppointmentRepoImpHttp implements AppointmentRepo {
  final AppointmentRemotData appointmentRemotData;
  final AppointmentLocalDataImp appointmentLocalData;
  AppointmentRepoImpHttp({
    required this.appointmentLocalData,
    required this.appointmentRemotData,
  });

  @override
  Future<Either<StatusRequest, AppointmentModel>> getAllAppointment(
      {required String userId}) async {
    if (await ckeckInternet()) {
      try {
        final remotData =
            await appointmentRemotData.getAllAppointment(userId: userId);
        appointmentLocalData.cachegetAppointment(
            key: 'APPOINTMENT_CACHE', appointment: remotData);

        log('from Server  ==> addAppointment Data   ');

        return right(remotData);
      } on ServerException catch (_) {
        return left(StatusRequest.serverFailure);
      }
    } else {
      try {
        final localData = appointmentLocalData.getCachedAppointmentModel(
          key: 'APPOINTMENT_CACHE',
        );
        log('from Cache  <== Appointment Data');
        return right(localData);
      } on EmptyCacheException {
        return left(StatusRequest.emptyCache);
      }
    }
  }

  @override
  Future<bool> addAppointment({required Appointment appointment}) async {
    if (await ckeckInternet()) {
      try {
        await appointmentRemotData.postAppointment(body: appointment.toJson());

        log('to Server  ==> addAppointment Data   ');
        showCustomSnackBar(message: Appointment_Added.tr, title: Done.tr);
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

  @override
  Future<bool> deleteAppointment({required appointmentId}) async {
    if (await ckeckInternet()) {
      try {
        await appointmentRemotData.deleteAppointment(
            appointmentId: appointmentId);

        log('to Server  ==> delete Appointment Data   ');
        showCustomSnackBar(message: Appointment_Canceled.tr, title: Done.tr);
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

  @override
  Future<bool> updateAppointment({required Appointment appointment}) async {
    if (await ckeckInternet()) {
      try {
        await appointmentRemotData.updatreAppointment(
            appointmentId: appointment.id, body: appointment.toJson());

        log('to Server  ==>  updateAppointment Data   ');
        showCustomSnackBar(message: Appointment_Updated.tr, title: Done.tr);
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
