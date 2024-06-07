import 'package:flutter_eassypharmacy/feature/features.dart';

// const String kLoginUserEmail = "login.user.email";
// const String kUserId = "user.id";
// const String kUserPhone = "user.phone";
// const String kFcmToken = "fcm.token";

//login
const String kIdUserLogin = "login.id";
const String kFullNameUserLogin = "login.fullName";
const String kPhoneNumberUserLogin = "login.phoneNumber";
const String kEmailUserLogin = "login.email";
const String kFcmTokenUserLogin = "login.fcmToken";

class AccountHelper {
  // static Future<void> saveUserInfo(String email, String password) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(kLoginUserEmail, email);
  // }

  static Future<void> saveUserInfoFromLogin(LoginModel verifiedModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kIdUserLogin, verifiedModel.data!.id.toString());
    prefs.setString(
        kFullNameUserLogin, verifiedModel.data!.fullName.toString());
    prefs.setString(
        kPhoneNumberUserLogin, verifiedModel.data!.phone.toString());
    prefs.setString(kEmailUserLogin, verifiedModel.data!.email.toString());
    prefs.setString(
        kFcmTokenUserLogin, verifiedModel.mobileFcmToken.toString());
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(kIdUserLogin);
    prefs.remove(kFullNameUserLogin);
    // prefs.remove(kPhoneNumberUserLogin);
    prefs.remove(kEmailUserLogin);
    prefs.remove(kFcmTokenUserLogin);
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kIdUserLogin);
  }

  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kFcmTokenUserLogin);
  }

  static Future<String?> getUserFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kFullNameUserLogin);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kEmailUserLogin);
  }

  static Future<String?> getUserPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kPhoneNumberUserLogin);
  }
}
