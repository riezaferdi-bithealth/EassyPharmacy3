import '../model.dart';

class GetListMedicines extends Model {
  bool? status;
  String? message;
  List<ListMedicines>? data;
  GetListMedicines({this.status, this.message, this.data});

  factory GetListMedicines.fromJson(Map<String, dynamic> json) =>
      GetListMedicines(
        status: Model.castBool(json["status"]),
        message: Model.castString(json['message']),
        data: Model.castList(json["data"])
            ?.map((data) => ListMedicines.fromJson(data))
            .toList(),
      );
}

class ListMedicines extends Model {
  int? id;
  String? name;
  String? desc;
  int? price;
  int? stock;
  String? image;
  
  ListMedicines({
    this.id,
    this.name,
    this.desc,
    this.price,
    this.stock,
    this.image,
  });

  factory ListMedicines.fromJson(Map<String, dynamic> json) => ListMedicines(
      id: Model.castInt(json['id']),
      name: Model.castString(json['name']),
      desc: Model.castString(json['description']),
      price: Model.castInt(json['price']),
      stock: Model.castInt(json['stock']),
      image: Model.castString(json['image']));
}
