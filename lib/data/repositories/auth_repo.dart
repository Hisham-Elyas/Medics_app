import '../../core/functions/ckeck_internet.dart';
import '../../core/functions/show_coustom_snackbar.dart';
import '../dataSoureces/remoteDataSource/auth_remotdata.dart';
import '../model/user_model.dart';

abstract class AuthRepo {
  Future<bool> signUp({required UserModel userModel});
  Future<bool> logIn({required UserModel userModel});
  Future<bool> reSetPassword({required String email});
  Future<bool> verifyCode({required String code});
  Future<bool> reSendVerifyCode({required String email});
  Future<bool> setNewPassword({required String code, required newPassword});
}

class AuthRepoImpFirebase implements AuthRepo {
  final AuthRemotDataImpFirebase authRemotData;

  AuthRepoImpFirebase({required this.authRemotData});

  @override
  Future<bool> signUp({required UserModel userModel}) async {
    if (await ckeckInternet()) {
      return await authRemotData.signUp(userModel: userModel);
    } else {
      showCustomSnackBar(
          message: "Ckeck your Internet ",
          title: 'Network Info ❗',
          isError: true);
      return false;
    }
  }

  @override
  Future<bool> logIn({required UserModel userModel}) async {
    if (await ckeckInternet()) {
      return await authRemotData.logIn(userModel: userModel);
    } else {
      showCustomSnackBar(
          message: "Ckeck your Internet ",
          title: 'Network Info ❗',
          isError: true);
    }
    return false;
  }

  @override
  Future<bool> reSendVerifyCode({required String email}) async {
    if (await ckeckInternet()) {
      return await authRemotData.reSendVerifyCode(email: email);
    } else {
      showCustomSnackBar(
          message: "Ckeck your Internet ",
          title: 'Network Info ❗',
          isError: true);
      return false;
    }
  }

  @override
  Future<bool> reSetPassword({required String email}) async {
    if (await ckeckInternet()) {
      return await authRemotData.reSetPassword(email: email);
    } else {
      showCustomSnackBar(
          message: "Ckeck your Internet ",
          title: 'Network Info ❗',
          isError: true);
      return false;
    }
  }

  @override
  Future<bool> setNewPassword(
      {required String code, required newPassword}) async {
    if (await ckeckInternet()) {
      return await authRemotData.setNewPassword(
          code: code, newPassword: newPassword);
    } else {
      showCustomSnackBar(
          message: "Ckeck your Internet ",
          title: 'Network Info ❗',
          isError: true);
      return false;
    }
  }

  @override
  Future<bool> verifyCode({required String code}) async {
    if (await ckeckInternet()) {
      return await authRemotData.verifyCode(code: code);
    } else {
      showCustomSnackBar(
          message: "Ckeck your Internet ",
          title: 'Network Info ❗',
          isError: true);
      return false;
    }
  }
}
// class AuthRepoImpHttp extends GetxService implements AuthRepo {
//   @override
//   logIn() {}

//   @override
//   resendVerifyCode() {}

//   @override
//   resetPassword() {}

//   @override
//   setNewPassword() {}

//   @override
//   signUp() {}

//   @override
//   verifyCode() {}
// }
