import 'package:cuer_city/middleware/middleware.dart';
import 'package:cuer_city/view/screen/home/chats/chats_screen.dart';
import 'package:get/get.dart';

import '../../controller/chats_controller.dart';
import '../../data/model/doctor_model.dart';
import '../../view/screen/auth/create_new_password_screen.dart';
import '../../view/screen/auth/login_screen.dart';
import '../../view/screen/auth/reset_password_screen.dart';
import '../../view/screen/auth/sign_up_screen.dart';
import '../../view/screen/auth/verify_code_screen.dart';
import '../../view/screen/home/doctors/doctors_detail_screen.dart';
import '../../view/screen/home/doctors/doctors_list_screen.dart';
import '../../view/screen/home/doctors/doctors_screen.dart';
import '../../view/screen/home/drugs/cart_screen.dart';
import '../../view/screen/home/drugs/drugs_screen.dart';
import '../../view/screen/home/main_screen.dart';
import '../../view/screen/home/myfavorite/my_favorite_screen.dart';
import '../../view/screen/onBording/on_boarding_screen.dart';
import '../../view/screen/onBording/start_screen.dart';

class AppRoutes {
  static const String onBoarding = '/';
  static const String startScreen = '/Start-Screen';
  static const String loginScreen = '/Login-Screen';
  static const String signUpScreen = '/SignUp-Screen';
  static const String resetPasswordScreen = '/Reset-Password';
  static const String verifyCodeScreen = '/Verify-Code';
  static const String createNewPasswordScreen = '/Create-New-Password';
  static const String homeScreen = '/Home-Screen';

  /// Drugs-Screen
  static const String drugsScrren = '/Drugs-Screen';
  static const String drugsDetailScrren = '/Drugs-Detail-Screen';
  static const String drugsCartScreen = '/Drugs-Cart-Screen';
  static const String drugsSearchScreen =
      '/Drugs-Search-Screen'; //SearchDrugsScreen
  /////  DoctorsScrren
  static const String doctorsScrren = '/Doctors-Screen';
  static const String doctorDetailScrren = '/Doctor-Detail-Screen';
  static const String doctorListScreen = '/Doctor-List-Screen';
  static const String favoriteScreen = '/Favorite-Screen';
  static const String chatsScreen = '/Chats-Screen';
  static String getOnBoardingn() => onBoarding;
  static String getStartScreen() => startScreen;
  static String getLoginScreen() => loginScreen;
  static String getSignUpScreen() => signUpScreen;
  static String getResetPasswordScreen() => resetPasswordScreen;
  static String getVerifyCodeScreen() => verifyCodeScreen;
  static String getCreateNewPasswordScreen() => createNewPasswordScreen;
  static String getHomeScreen() => homeScreen;

  /// profile screen

  static String getFavoriteScreen() => favoriteScreen;
  static String getChatsScreenScreen(Doctor doctorinfo) =>
      "$chatsScreen?Doctorinfo=${doctorinfo.toJson()}";

  /// Drugs-Screen
  static String getDrugsScrren() => drugsScrren;
  static String getDrugsDetailScrren() => drugsDetailScrren;
  static String getDrugsCartScreen() => drugsCartScreen;
  static String getDrugsSearchScreen() => drugsSearchScreen;
  /////  DoctorsScrren
  static String getDoctorsScreen() => doctorsScrren;
  static String getDoctorDetailScrren(Doctor doctorinfo) =>
      '$doctorDetailScrren?Doctorinfo=${doctorinfo.toJson()}';
  static String getDoctorListScreen(String category) =>
      '$doctorListScreen?Category=$category';
  static List<GetPage<dynamic>>? myPages = [
    GetPage(
        name: onBoarding,
        page: () => const OnBoarding(),
        middlewares: [MyMiddleware()],
        transition: Transition.circularReveal),
    GetPage(
        name: startScreen,
        page: () => const StartScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: loginScreen,
        page: () => const LoginScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: signUpScreen,
        page: () => const SignUpScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: resetPasswordScreen,
        page: () => const ResetPasswordScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: verifyCodeScreen,
        page: () => const VerifyCodeScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: createNewPasswordScreen,
        page: () => const CreateNewPasswordScreen(),
        transition: Transition.circularReveal),
    GetPage(
        name: homeScreen,
        // page: () => const HomeScreen(),
        page: () => MainScreen(),
        transition: Transition.circularReveal),

    /// Drugs-Screen
    GetPage(
        name: drugsScrren,
        page: () => const DrugsScrren(),
        transition: Transition.circularReveal),
    // GetPage(
    //     name: drugsDetailScrren,
    //     // page: () {
    //       // final product = Get.parameters['Product'];
    //       // return DrugsDetailScrren();
    //     // },
    //     transition: Transition.circularReveal),
    GetPage(
        name: drugsCartScreen,
        page: () => const CartScreen(),
        transition: Transition.circularReveal),
    // GetPage(
    //     name: drugsSearchScreen,
    //     page: () => const SearchDrugsScreen(),
    //     transition: Transition.circularReveal),
    /////  DoctorsScrren
    GetPage(
        name: doctorsScrren,
        page: () => const DoctorsScrren(),
        transition: Transition.circularReveal),
    GetPage(
        name: doctorDetailScrren, //Doctorinfo
        page: () {
          final doctorinfo = Doctor.fromJson(Get.parameters['Doctorinfo']!);
          // print(doctorinfo.name);
          // print(DoctorModel.fromMap(Doctorinfo));
          return DoctorDetailScrren(
            doctorinfo: doctorinfo,
          );
        },
        transition: Transition.circularReveal),
    GetPage(
        name: doctorListScreen,
        page: () {
          final category = Get.parameters['Category'];
          return DoctorListScreen(category: category!);
        },
        transition: Transition.circularReveal),
    GetPage(
        name: favoriteScreen,
        page: () {
          return const MyFavoriteScreen();
        },
        transition: Transition.circularReveal),
    GetPage(
        name: chatsScreen,
        page: () {
          final doctorinfo = Doctor.fromJson(Get.parameters['Doctorinfo']!);
          return ChatsScreen(doctor: doctorinfo);
        },
        bindings: [
          BindingsBuilder.put(() => ChatsController()),
        ],
        transition: Transition.circularReveal),
  ];
}
