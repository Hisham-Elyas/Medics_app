import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../data/model/doctor_model.dart';
import '../data/repositories/docters_repo.dart';

enum Specialty {
  Surgeon,
  LungsSpecialist,
  Dentist,
  Psychiatrist,
  General,
  Cardiologist,
  Covid
}

class DoctorController extends GetxController {
  late StatusRequest statusReq;
  final DoctorsRepoImpHttp drugsRepo = Get.find();
  @override
  void onInit() {
    super.onInit();
    getAllDoctors();
  }

  final List<Doctor> doctorlist = [];
  late final Specialty complexity = Specialty.Cardiologist;

  Future<void> getAllDoctors() async {
    statusReq = StatusRequest.loading;
    update();
    final data = await drugsRepo.getAllDoctors();
    data.fold((l) {
      statusReq = l;
      update();
    }, (r) {
      doctorlist.clear();
      doctorlist.addAll(r.doctor);
      statusReq = StatusRequest.success;

      update();
    });
  }

  List<Doctor?> filterDoctors(String specialty) {
    List<Doctor?> newlist = [];
    for (var el in doctorlist) {
      if (el.specialty == specialty) {
        //192.168.3.227
        newlist.add(el);
      }
    }

    return newlist;
  }

  String whatSpecialty(Specialty specialty) {
    // final specialty = Category.Covid;
    switch (specialty) {
      case Specialty.General:
        return 'General';
      case Specialty.LungsSpecialist:
        return 'LungsSpecialist';
      case Specialty.Dentist:
        return 'Dentist';
      case Specialty.Psychiatrist:
        return 'Psychiatrist';
      case Specialty.Surgeon:
        return 'Surgeon';
      case Specialty.Cardiologist:
        return 'Cardiologist';
      case Specialty.Covid:
        return 'Covid';
      default:
        return 'Unknown';
    }
  }
}
