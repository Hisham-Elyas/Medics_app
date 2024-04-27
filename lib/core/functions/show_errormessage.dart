import 'package:cuer_city/core/functions/show_coustom_snackbar.dart';

showErrorMessage(String? message) {
  if (message == null) {
    return;
  }
  if (message == '404') {
    showCustomSnackBar(
        message: 'Please try something else',
        title: 'No valid entry found ❗',
        isError: true);
  } else {
    showCustomSnackBar(
        message: 'Please try agein later',
        title: 'Unexpected Error ❗',
        isError: true);
  }
}

showNetworkError() {
  showCustomSnackBar(
      message: "Ckeck your Internet ", title: 'Network Info ❗', isError: true);
}
