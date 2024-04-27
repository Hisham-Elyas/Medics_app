import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../core/functions/show_coustom_snackbar.dart';
import '../../model/user_model.dart';

abstract class AuthRemotData {
  Future<bool> signUp({required UserModel userModel});
  Future<bool> logIn({required UserModel userModel});
  Future<bool> reSetPassword({required String email});
  Future<bool> verifyCode({required String code});
  Future<bool> reSendVerifyCode({required String email});
  Future<bool> setNewPassword({required String code, required newPassword});
}

class AuthRemotDataImpFirebase implements AuthRemotData {
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool> signUp({required UserModel userModel}) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password!);
      userModel = UserModel(
          email: userModel.email,
          userName: userModel.userName,
          userId: userCredential.user!.uid);

      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'user_info': userModel.toMap()}, SetOptions(merge: true));
      // final h = await firebaseFirestore
      //     .collection('users')
      //     .doc(userCredential.user!.uid)
      //     .get();
      // print('===============================');
      // print(h.data()!['user_info']);
      // final dat = UserModel.fromMap(h.data()!['user_info']);
      // print(dat.userName);
      return true;
    } on FirebaseException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'Auth Error', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> logIn({required UserModel userModel}) async {
    // firebaseAuth.signOut();
    // return;
    // printInfo(info: userModel.password.toString());
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.password!);
      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> reSendVerifyCode({required String email}) async {
    // firebaseAuth.currentUser!.sendEmailVerification();

    return await reSetPassword(email: email);
  }

  @override
  Future<bool> reSetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);

      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
    // firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<bool> setNewPassword(
      {required String code, required newPassword}) async {
    try {
      // firebaseAuth.confirmPasswordReset(code: code, newPassword: newPassword);
      await Future.delayed(const Duration(seconds: 2));

      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }

  @override
  Future<bool> verifyCode({required String code}) async {
    try {
      // await firebaseAuth.verifyPasswordResetCode(code);
      await Future.delayed(const Duration(seconds: 2));

      return true;
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(
          message: "${e.message}", title: 'INVALID LOGIN INFO', isError: true);

      printError(info: "Failed with error '${e.code}' :  ${e.message}");
      return false;
    } catch (e) {
      printError(info: e.toString());

      return false;
    }
  }
}

// class AuthRemotDataImpHttp extends GetxService implements AuthRepo {
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
