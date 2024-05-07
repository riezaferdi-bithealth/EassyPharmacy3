import 'package:flutter_eassypharmacy/feature/features.dart';

const String kLoginUserEmail = "login.user.email";
const String kUserId = "user.id";
const String kUserPhone = "user.phone";
const String kFcmToken = "fcm.token";

//login
const String kFullNameUserRegister = "register.fullName";
const String kPhoneNumberUserRegister = "register.phoneNumber";
const String kEmailUserRegister = "register.email";
const String kFcmTokenUserRegister = "register.fcmToken";
const String kTokenUserRegister = "register.token";

class AccountHelper {
  static Future<void> saveUserInfo(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kLoginUserEmail, email);
  }

  static Future<void> saveUserInfoFromLogin(LoginModel verifiedModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(kFullNameUserRegister, verifiedModel.fullName.toString());
    // prefs.setString(
    //     kPhoneNumberUserRegister, verifiedModel.phoneNumber.toString());

    prefs.setString(kEmailUserRegister, verifiedModel.email.toString());
    prefs.setString(
        kFcmTokenUserRegister, verifiedModel.mobileFcmToken.toString());
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(kUserId);
    prefs.remove(kFullNameUserRegister);
    prefs.remove(kPhoneNumberUserRegister);
    prefs.remove(kEmailUserRegister);
    prefs.remove(kFcmTokenUserRegister);
    prefs.remove(kTokenUserRegister);
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kUserId);
  }

  static Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kTokenUserRegister);
  }

  static Future<String?> getUserFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kFullNameUserRegister);
  }
}
