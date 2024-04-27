import 'package:shared_preferences/shared_preferences.dart';


const String kLoginUserEmail = "login.user.email";
const String kUserId = "user.id";
const String kUserToken = "user.token";
const String kUserPhone = "user.phone";
const String kFcmToken = "fcm.token";

//Login
// const String kFullNameUserLogin = "Login.fullName";
// const String kPhoneNumberUserLogin = "Login.phoneNumber";
// const String kCountryCodeUserLogin = "Login.countryCode";
// const String kEmailUserLogin = "Login.email";
// const String kFcmTokenUserLogin = "Login.fcmToken";
// const String kTokenUserLogin = "Login.token";

//register
const String kFullNameUserRegister = "register.fullName";
const String kPhoneNumberUserRegister = "register.phoneNumber";
const String kCountryCodeUserRegister = "register.countryCode";
const String kEmailUserRegister = "register.email";
const String kFcmTokenUserRegister = "register.fcmToken";
const String kTokenUserRegister = "register.token";

//profile detail
const String kPhotoProfileDetail = "profile.photo";

class AccountHelper {
  static Future<void> saveUserInfo(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kLoginUserEmail, email);
  }

  // static Future<void> saveUserInfoRegister(VerifyOtpModel verifiedModel) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(kUserId, verifiedModel.id.toString());
  //   prefs.setString(kFullNameUserRegister, verifiedModel.fullName.toString());
  //   prefs.setString(
  //       kPhoneNumberUserRegister, verifiedModel.phoneNumber.toString());
  //   prefs.setString(
  //       kCountryCodeUserRegister, verifiedModel.countryCode.toString());
  //   prefs.setString(kEmailUserRegister, verifiedModel.email.toString());
  //   prefs.setString(
  //       kFcmTokenUserRegister, verifiedModel.mobileFcmToken.toString());
  //   prefs.setString(kTokenUserRegister, verifiedModel.token.toString());
  // }

  // static Future<void> saveUserInfoFromLogin(
  //     VerifyOtpModel verifiedModel) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   prefs.setString(kFullNameUserRegister, verifiedModel.fullName.toString());
  //   prefs.setString(
  //       kPhoneNumberUserRegister, verifiedModel.phoneNumber.toString());
  //   prefs.setString(
  //       kCountryCodeUserRegister, verifiedModel.countryCode.toString());
  //   prefs.setString(kEmailUserRegister, verifiedModel.email.toString());
  //   prefs.setString(
  //       kFcmTokenUserRegister, verifiedModel.mobileFcmToken.toString());
  //   prefs.setString(kTokenUserRegister, verifiedModel.token.toString());
  // }

  // static Future<void> saveUserProfile(PatientData patientProfile) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(
  //       kPhotoProfileDetail, patientProfile.patientImageUrl.toString());
  // }

  static Future<void> saveLoginEmailPassword(
      String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kLoginUserEmail, email);
  }

  static Future<void> saveLoginEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kLoginUserEmail, email);
  }

  static Future<void> saveAuthToken(String userToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kUserToken, userToken);
  }

  static Future<void> saveFcmToken(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kFcmToken, fcmToken);
  }

  static Future<String?> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kFcmToken);
  }

  static Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kUserToken);
  }

  static Future<String?> getLoginEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kLoginUserEmail);
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(kUserId);
    prefs.remove(kFullNameUserRegister);
    prefs.remove(kPhoneNumberUserRegister);
    prefs.remove(kCountryCodeUserRegister);
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

  static Future<String?> getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kUserPhone);
  }

  static Future<String?> getUserFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kFullNameUserRegister);
  }

  static Future<void> saveUserPhone(String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kUserPhone, userPhone);
  }

  static Future<String?> getUserPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kPhotoProfileDetail);
  }
}