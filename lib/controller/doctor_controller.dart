import 'package:get/get.dart';

import '../core/class/enums.dart';
import '../data/model/doctor_model.dart';
import '../data/repositories/docters_repo.dart';

class DoctorController extends GetxController {
  late StatusRequest statusReq;
  final DoctorsRepoImpHttp drugsRepo = Get.find();
  @override
  void onInit() {
    super.onInit();
    getAllDoctors();
  }

  final List<Doctor> doctorlist = [];

  List<Doctor>? filter(String query) {
    List<Doctor>? filter = [];

    if (query == "") {
      return doctorlist;
    } else {
      filter = doctorlist.where((element) {
        return element.name!.toUpperCase().startsWith(query.toUpperCase());
      }).toList();

      return filter;
    }
  }

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
        newlist.add(el);
      }
    }

    return newlist;
  }
}
