import '../model.dart';

class CartModel extends Model {
  bool? status;
  String? message;
  List<CartItems>? data;
  CartModel({this.status, this.message, this.data});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        status: Model.castBool(json["status"]),
        message: Model.castString(json['message']),
        data: Model.castList(json["data"])
            ?.map((data) => CartItems.fromJson(data))
            .toList(),
      );
}

class CartItems extends Model {
  int? id;
  String? name;
  int? price;

  CartItems({
    this.id,
    this.name,
    this.price,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
        id: Model.castInt(json['id']),
        name: Model.castString(json['name']),
        price: Model.castInt(json['price']),
      );
}
