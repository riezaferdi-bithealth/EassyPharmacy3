part of engine;

class Cart extends VmsEngine {
  @override
  String get tag => '';

  Future<BaseModel<CartModel>>? addCart(
    int? idUser,
    List<dynamic>? listItems,
  ) async {
    String url = "${VmsEngine.url!}/orders/cart";

    var uri = Uri.parse(url);

    var param = jsonEncode({"id_user": idUser, "list_medicines": listItems});

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

  Future<BaseModel<CartModel>>? removeCart(
    int? idUser,
    List<dynamic>? listItems,
  ) async {
    final String jsonString = jsonEncode(listItems);
    String url = "${VmsEngine.url!}/orders/cart/item/$idUser/$jsonString";

    var uri = Uri.parse(url);

    var param = jsonEncode({});

    var result = await _process(
      url: uri.toString(),
      param: param,
      contentType: ContentType.json,
      tokenType: TokenType.none,
      requestType: RequestType.delete,
      processName: "remove Cart",
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

  Future<BaseModel<CartModel>>? orderCart(
    int? idUser,
    List<dynamic>? listItems,
  ) async {
    String url = "${VmsEngine.url!}/orders/checkout";

    var uri = Uri.parse(url);

    var param = jsonEncode({"id_user": idUser, "list_medicines": listItems});

    var result = await _process(
      url: uri.toString(),
      param: param,
      contentType: ContentType.json,
      tokenType: TokenType.none,
      requestType: RequestType.post,
      processName: "order checkout Cart",
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

  Future<BaseModel<HistoryOrderModel>>? getHistoryOrder() async {
    String url = "${VmsEngine.url!}/orders/history";

    var uri = Uri.parse(url);

    var result = await _process(
      url: uri.toString(),
      contentType: ContentType.json,
      tokenType: TokenType.user,
      requestType: RequestType.get,
      processName: "get History Order",
    );

    if (result['status'] == true) {
      return BaseModel(
        status: result['status'],
        value:
            result['data'] != null ? HistoryOrderModel.fromJson(result) : null,
      );
    } else {
      return BaseModel(
        status: result['status'],
        message: result['message'],
      );
    }
  }
}
