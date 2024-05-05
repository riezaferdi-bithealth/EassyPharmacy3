import 'package:flutter_eassypharmacy/core/core.dart';

class Commons {
  void snackbarError(
    BuildContext context,
    String message,
  ) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: systemRedColor,
      duration: const Duration(milliseconds: 2500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  void snackbarSuccess(
    BuildContext context,
    String message,
  ) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: systemAccent500Color,
      duration: const Duration(milliseconds: 2500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
