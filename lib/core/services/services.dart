import 'package:cuer_city/controller/chats_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/appointment_controller.dart';
import '../../controller/doctor_controller.dart';
import '../../controller/drugs_controller.dart';
import '../../controller/forgot_password_controller.dart';
import '../../controller/login_screen_controller.dart';
import '../../controller/sign_up_screen_controller.dart';
import '../../data/dataSoureces/localDataSource/appointment_localdata.dart';
import '../../data/dataSoureces/localDataSource/doctors_localdata.dart';
import '../../data/dataSoureces/localDataSource/durgs_localdata.dart';
import '../../data/dataSoureces/remoteDataSource/appointment_remotdata.dart';
import '../../data/dataSoureces/remoteDataSource/auth_remotdata.dart';
import '../../data/dataSoureces/remoteDataSource/doctors_remotdata.dart';
import '../../data/dataSoureces/remoteDataSource/durgs_remotdata.dart';
import '../../data/repositories/appointment_repo.dart';
import '../../data/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../data/repositories/docters_repo.dart';
import '../../data/repositories/drugs_repo.dart';
import '../../firebase_options.dart';
import '../class/api_client.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  late FirebaseAuth firebaseAuth;
  Future<MyServices> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    sharedPreferences = await SharedPreferences.getInstance();
    firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        printInfo(info: " User is login by ${user.uid}");
        printInfo(info: " User is login by ${user.email!}");
      } else {
        printInfo(info: " not User is login ");
      }
    });

    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
  ////////////// Auth Controller
  Get.lazyPut(() => LoginScreenController(), fenix: true);
  Get.lazyPut(() => SignUpScreenController(), fenix: true);
  Get.lazyPut(() => ResstPasswordController(), fenix: true);
  ////////////// Auth data
  Get.lazyPut(() => AuthRemotDataImpFirebase(), fenix: true);
  Get.lazyPut(() => AuthRepoImpFirebase(authRemotData: Get.find()),
      fenix: true);

  ///  api client
  Get.lazyPut(() => ApiClent(), fenix: false);

  ////////////// DrugsController
  Get.lazyPut(() => DrugsController(), fenix: true);

  ///  Drugs data
  Get.lazyPut(() => DrugsRemotDataImpHttp(apiClent: Get.find()), fenix: false);
  Get.lazyPut(() => DrugsLocalDataImp(myServices: Get.find()), fenix: false);
  Get.lazyPut(
      () => DrugsRepoImpHttp(
          drugsRemotData: Get.find(), drugslocalData: Get.find()),
      fenix: true);

  ////////////// Appointment Controller\

  Get.lazyPut(() => ApointmentController(), fenix: true);

  ///  Appointment data
  Get.lazyPut(() => AppointmentRemotDataImpHttp(apiClent: Get.find()),
      fenix: false);
  Get.lazyPut(() => AppointmentLocalDataImp(myServices: Get.find()),
      fenix: false);
  Get.lazyPut(
      () => AppointmentRepoImpHttp(
          appointmentLocalData: Get.find(), appointmentRemotData: Get.find()),
      fenix: false);

  ////////////// DoctorsController
  Get.lazyPut(() => DoctorController(), fenix: true);

  ///  Doctor data
  Get.lazyPut(() => DoctorsRemotDataImpHttp(apiClent: Get.find()),
      fenix: false);
  Get.lazyPut(() => DoctorsLocalDataImp(myServices: Get.find()), fenix: false);
  Get.lazyPut(
      () => DoctorsRepoImpHttp(
          doctorsLocalData: Get.find(), doctorsRemotData: Get.find()),
      fenix: false);

  ///  Doctor data
  // Get.lazyPut(() => ChatsController(), fenix: false);
}
