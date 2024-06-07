import '../model.dart';

class HistoryOrderModel extends Model {
  bool? status;
  String? message;
  List<StructModel>? data;
  HistoryOrderModel({this.status, this.message, this.data});

  factory HistoryOrderModel.fromJson(Map<String, dynamic> json) =>
      HistoryOrderModel(
        status: Model.castBool(json["status"]),
        message: Model.castString(json['message']),
        data: Model.castList(json["data"])
            ?.map((data) => StructModel.fromJson(data))
            .toList(),
      );
}

class StructModel extends Model {
  int? idStruct;
  int? idUser;
  String? dateOrder;
  List<CartItems>? data;

  StructModel({this.idStruct, this.idUser, this.dateOrder, this.data});

  factory StructModel.fromJson(Map<String, dynamic> json) => StructModel(
        idStruct: Model.castInt(json['id_struct']),
        idUser: Model.castInt(json['id_user']),
        dateOrder: Model.castString(json['date_order']),
        data: Model.castList(json["list_medicines"])
            ?.map((data) => CartItems.fromJson(data))
            .toList(),
      );
}

class HistoryItems extends Model {
  int? id;
  String? name;
  int? price;
  String? image;
  int? qty;
  int? totalPrice;

  HistoryItems(
      {this.id, this.name, this.price, this.image, this.qty, this.totalPrice});

  factory HistoryItems.fromJson(Map<String, dynamic> json) => HistoryItems(
        id: Model.castInt(json['id']),
        name: Model.castString(json['name']),
        qty: Model.castInt(json['qty']),
        price: Model.castInt(json['price']),
        image: Model.castString(json['image']),
        totalPrice: Model.castInt(json['total_price']),
      );
}
