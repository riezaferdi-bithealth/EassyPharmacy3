import 'model.dart';

class BaseModel<T> {
  final T? value;
  final bool? status;
  final String? message;

  BaseModel({this.status, this.value, this.message});

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        value: json["data"],
        status: Model.castBool(json["status"]),
        message: Model.castString(json["message"]),
      );
}