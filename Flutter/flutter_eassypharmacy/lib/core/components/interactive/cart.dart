part of engine;

class Cart extends VmsEngine {
  @override
  String get tag => '';

//   import "dart:convert";

// "id_struct": MathHelper().getRandomString(uidLength),

// void main() {
//   const id = 17;
//   const data = [{"id": 3,"price": 7500}];
//   final String jsonString = jsonEncode(data);
//   print("http://localhost:3000/orders/cart/item/$id/$jsonString");
// }

  Future<BaseModel<CartModel>>? saveCart(
    int? idUser,
    List<dynamic>? listItems
    // int? idItems,
    // String? nameItems,
    // int? priceItems,
  ) async {
    // final response =
    //     await rootBundle.loadString('assets/json/Cart.json');
    // final result = await json.decode(response);
    String url = "${VmsEngine.url!}/orders/cart";

    var uri = Uri.parse(url);

    var param = jsonEncode({
      "id_user": idUser,
      "list_medicines": listItems
      // [
      //   {
      //     "id": idItems,
      //     "name": nameItems,
      //     "price": priceItems,
      //   }
      // ]
    });

    print("param ${param}");

    var result = await _process(
      url: uri.toString(),
      param: param,
      contentType: ContentType.json,
      tokenType: TokenType.none,
      requestType: RequestType.post,
      processName: "submit Cart",
    );

    if (result['status'] == true) {
      return BaseModel(
        status: result['status'],
        value: result['data'] != null ? CartModel.fromJson(result) : null,
      );
    } else {
      return BaseModel(
        status: result['status'],
        message: result['message'],
      );
    }
  }
}
