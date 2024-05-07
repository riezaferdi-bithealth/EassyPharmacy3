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
    this.email,
    this.mobileFcmToken,
  });

  int? id;
  String? fullName;
  String? mobileFcmToken;
  String? email;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: Model.castInt(json["id"]),
        fullName: Model.castString(json["fullname"]),
        email: Model.castString(json["email"]),
        mobileFcmToken: Model.castString(json["mobile_fcm_token"]),
      );
}
