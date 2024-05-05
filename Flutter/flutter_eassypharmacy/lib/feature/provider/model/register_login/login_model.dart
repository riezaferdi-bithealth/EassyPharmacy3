import '../model.dart';

class Login extends Model {
  Login({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  LoginModel? data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: Model.castBool(json["status"]),
        message: Model.castString(json["message"]),
        data: json["data"] == null ? null : LoginModel.fromJson(json["data"]),
      );
}

class LoginModel {
  LoginModel({
    this.id,
    this.fullName,
    this.mobileFcmToken,
    this.email,
  });

  int? id;
  String? fullName;
  String? mobileFcmToken;
  String? email;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: Model.castInt(json["user"]["id"]),
        fullName: Model.castString(json["user"]["fullname"]),
        mobileFcmToken: Model.castString(json["user"]["mobile_fcm_token"]),
        email: Model.castString(json["user"]["email"]),
      );
}
