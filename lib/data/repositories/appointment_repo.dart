import 'dart:developer';

import 'package:cuer_city/core/functions/show_coustom_snackbar.dart';
import 'package:cuer_city/data/model/apointment_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/class/enums.dart';
import '../../core/error/exception.dart';
import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_errormessage.dart';
import '../dataSoureces/localDataSource/appointment_localdata.dart';
import '../dataSoureces/remoteDataSource/appointment_remotdata.dart';

abstract class AppointmentRepo {
  Future<Either<StatusRequest, AppointmentModel>> getAllAppointment();

  Future<bool> addAppointment({required Appointment appointment});
  Future<bool> updateAppointment({required Appointment appointment});
  Future<bool> deleteAppointment({required appointmentId});
}

class AppointmentRepoImpHttp implements AppointmentRepo {
  final AppointmentRemotDataImpHttp appointmentRemotData;
  final AppointmentLocalDataImp appointmentLocalData;
  AppointmentRepoImpHttp({
    required this.appointmentLocalData,
    required this.appointmentRemotData,
  });

  @override
  Future<Either<StatusRequest, AppointmentModel>> getAllAppointment() async {
    if (await ckeckInternet()) {
      try {
        final remotData = await appointmentRemotData.getAllAppointment();
        appointmentLocalData.cachegetAppointment(
            key: 'APPOINTMENT_CACHE', appointment: remotData);

        log('from Server  ==> addAppointment Data   ');

        return right(remotData);
      } on ServerException catch (_) {
        // if (e.message != '404') {
        //   showErrorMessage(e.message);
        // }

        return left(StatusRequest.serverFailure);
      }
    } else {
      try {
        final localData = await appointmentLocalData.getCachedAppointmentModel(
          key: 'APPOINTMENT_CACHE',
        );
        log('from Cache  <== Appointment Data');
        return right(localData);
      } on EmptyCacheException {
        // showNetworkError();
        // showCustomSnackBar(
        //     message: "No Data Ckeck your Internet ",
        //     title: 'Empty Cache ❗',
        //     isError: true);

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
        showCustomSnackBar(message: 'Appointment Added', title: 'Done ✅');
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
        showCustomSnackBar(
            message: 'Appointment Canceled 🗑 ', title: 'Done ✅');
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
        showCustomSnackBar(message: 'Appointment Updated', title: 'Done ✅');
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
