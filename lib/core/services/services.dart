import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../controller/appointment_controller.dart';
import '../../controller/doctor_controller.dart';
import '../../controller/drugs_controller.dart';
import '../../controller/forgot_password_controller.dart';
import '../../controller/location_controller.dart';
import '../../controller/login_screen_controller.dart';
import '../../controller/notifications_controller.dart';
import '../../controller/order_controller.dart';
import '../../controller/settings_controller.dart';
import '../../controller/sign_up_screen_controller.dart';
import '../../controller/user_controller.dart';
import '../../data/dataSoureces/localDataSource/appointment_localdata.dart';
import '../../data/dataSoureces/localDataSource/doctors_localdata.dart';
import '../../data/dataSoureces/localDataSource/durgs_localdata.dart';
import '../../data/dataSoureces/remoteDataSource/appointment_remotdata.dart';
import '../../data/dataSoureces/remoteDataSource/auth_remotdata.dart';
import '../../data/dataSoureces/remoteDataSource/chats_remotdata.dart';
import '../../data/dataSoureces/remoteDataSource/doctors_remotdata.dart';
import '../../data/dataSoureces/remoteDataSource/durgs_remotdata.dart';
import '../../data/dataSoureces/remoteDataSource/orders_remotdata.dart';
import '../../data/repositories/appointment_repo.dart';
import '../../data/repositories/auth_repo.dart';

import '../../data/repositories/chats_repo.dart';
import '../../data/repositories/docters_repo.dart';
import '../../data/repositories/drugs_repo.dart';
import '../../data/repositories/orders_repo.dart';
import '../../firebase_options.dart';
import '../class/api_client.dart';
import '../class/local_notification.dart';
import '../localization/changelocal_controller.dart';

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
        log(" User is login by ${user.uid}");
        log(" User is login by ${user.email!}");
      } else {
        log("............... not User is login ");
      }
    });

    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
  await LocalNotifications.init();

  Get.lazyPut(() => LocaleController(), fenix: true);
  ////////////// Auth Controller
  Get.lazyPut(() => LoginScreenController(), fenix: true);
  Get.lazyPut(() => SignUpScreenController(), fenix: true);
  Get.lazyPut(() => ResstPasswordController(), fenix: true);
  Get.lazyPut(() => UserController(), fenix: true);
  ////////////// Auth data
  Get.lazyPut(() => AuthRemotDataImpFirebase(), fenix: true);
  Get.lazyPut(() => AuthRepoImpFirebase(authRemotData: Get.find()),
      fenix: true);

  ///  Location Controller
  Get.lazyPut(() => LocationController(), fenix: true);

  ///  api client
  Get.lazyPut(() => ApiClent(), fenix: true);

  ///  Order Controller
  Get.lazyPut(() => OrderController(), fenix: true);
  //  Order data
  Get.lazyPut(() => OrderRemotDataImpHttp(apiClent: Get.find()), fenix: true);
  Get.lazyPut(() => OrderRepoImpHttp(orderRemotData: Get.find()), fenix: true);

  ////////////// DrugsController
  Get.lazyPut(() => DrugsController(), fenix: true);

  ///  Drugs data
  Get.lazyPut(() => DrugsRemotDataImpHttp(apiClent: Get.find()), fenix: true);
  Get.lazyPut(() => DrugsLocalDataImp(myServices: Get.find()), fenix: true);
  Get.lazyPut(
      () => DrugsRepoImpHttp(
          drugsRemotData: Get.find(), drugslocalData: Get.find()),
      fenix: true);

  ////////////// Notification Controller
  Get.lazyPut(() => NotificationController(), fenix: true);

  ////////////// Notification Settings
  Get.lazyPut(() => SettingsController(), fenix: true);

  ////////////// Appointment Controller

  Get.lazyPut(
      () => ApointmentController(
          appointmentRepo2: Get.find<AppointmentRepoImpHttp>()),
      fenix: true);

  ///  Appointment data
  Get.lazyPut(
      () => AppointmentRemotDataImpHttp(
            apiClent: Get.find(),
          ),
      fenix: true);
  Get.lazyPut(() => AppointmentLocalDataImp(myServices: Get.find()),
      fenix: true);
  Get.lazyPut(
      () => AppointmentRepoImpHttp(
          appointmentLocalData: Get.find(),
          appointmentRemotData: Get.find<AppointmentRemotDataImpHttp>()),
      fenix: true);

  ////////////// DoctorsController
  Get.lazyPut(() => DoctorController(), fenix: true);

  ///  Doctor data
  Get.lazyPut(() => DoctorsRemotDataImpHttp(apiClent: Get.find()), fenix: true);
  Get.lazyPut(() => DoctorsLocalDataImp(myServices: Get.find()), fenix: true);
  Get.lazyPut(
      () => DoctorsRepoImpHttp(
          doctorsLocalData: Get.find(), doctorsRemotData: Get.find()),
      fenix: true);

  ///  Chats data
  Get.lazyPut(() => ChatRemotDataImpFirebase(), fenix: true);
  Get.lazyPut(() => ChatRepoImpFirebase(chatRemotData: Get.find()),
      fenix: true);
}
