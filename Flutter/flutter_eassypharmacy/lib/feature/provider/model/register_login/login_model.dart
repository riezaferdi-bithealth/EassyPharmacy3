import '../model.dart';

class LoginModel extends Model {
  LoginModel({
    this.status,
    this.message,
    this.data,
    this.mobileFcmToken,
  });

  bool? status;
  String? message;
  UserModel? data;
  String? mobileFcmToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: Model.castBool(json["status"]),
        message: Model.castString(json["message"]),
        data: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        mobileFcmToken: Model.castString(json["mobile_fcm_token"]),
      );
}

class UserModel {
  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
  });

  int? id;
  String? fullName;
  String? email;
  String? phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: Model.castInt(json["id"]),
        fullName: Model.castString(json["fullname"]),
        email: Model.castString(json["email"]),
        phone: Model.castString(json["phoneNumber"]),
      );
}
