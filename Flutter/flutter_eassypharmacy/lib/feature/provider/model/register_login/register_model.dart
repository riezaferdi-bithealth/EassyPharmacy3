import '../model.dart';

class Register extends Model {
  Register({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  RegisterModel? data;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        status: Model.castBool(json["status"]),
        message: Model.castString(json["message"]),
        data:
            json["data"] == null ? null : RegisterModel.fromJson(json["data"]),
      );
}

class RegisterModel {
  RegisterModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
  });

  int? id;
  String? fullName;

  String? phoneNumber;
  String? email;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        id: Model.castInt(json["id"]),
        fullName: Model.castString(json["fullname"]),
        phoneNumber: Model.castString(json["phone"]),
        email: Model.castString(json["email"]),
      );
}
