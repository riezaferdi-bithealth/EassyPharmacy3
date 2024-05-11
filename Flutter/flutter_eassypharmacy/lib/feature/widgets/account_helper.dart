import 'package:flutter_eassypharmacy/feature/features.dart';

const String kLoginUserEmail = "login.user.email";
const String kUserId = "user.id";
const String kUserPhone = "user.phone";
const String kFcmToken = "fcm.token";

//login
const String kIdUserLogin = "register.login";
const String kFullNameUserLogin = "register.fullName";
const String kPhoneNumberUserLogin = "register.phoneNumber";
const String kEmailUserLogin = "register.email";
const String kFcmTokenUserLogin = "register.fcmToken";
const String kTokenUserLogin = "register.token";

class AccountHelper {
  static Future<void> saveUserInfo(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kLoginUserEmail, email);
  }

  static Future<void> saveUserInfoFromLogin(LoginModel verifiedModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kIdUserLogin, verifiedModel.fullName.toString());
    prefs.setString(kFullNameUserLogin, verifiedModel.fullName.toString());
    // prefs.setString(
    //     kPhoneNumberUserLogin, verifiedModel.phoneNumber.toString());
    prefs.setString(kEmailUserLogin, verifiedModel.email.toString());
    prefs.setString(
        kFcmTokenUserLogin, verifiedModel.mobileFcmToken.toString());
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(kUserId);
    prefs.remove(kFullNameUserLogin);
    prefs.remove(kPhoneNumberUserLogin);
    prefs.remove(kEmailUserLogin);
    prefs.remove(kFcmTokenUserLogin);
    prefs.remove(kTokenUserLogin);
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kUserId);
  }

  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kTokenUserLogin);
  }

  static Future<String?> getUserFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kFullNameUserLogin);
  }
}
