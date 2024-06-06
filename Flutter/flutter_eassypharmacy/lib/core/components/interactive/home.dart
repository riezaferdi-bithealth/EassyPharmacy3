part of engine;

class Home extends VmsEngine {
  @override
  String get tag => '';

  Future<BaseModel<GetListMedicines>>? getListMedicines(
    String? searchKey
  ) async {

    String url = "${VmsEngine.url!}/drug?search=$searchKey&page[size]=20";

    var uri = Uri.parse(url);

    var result = await _process(
      url: uri.toString(),
      contentType: ContentType.json,
      tokenType: TokenType.none,
      requestType: RequestType.get,
      processName: "get list medicines",
    );

    if (result['status'] == true) {
      return BaseModel(
          status: result['status'],
          value: GetListMedicines.fromJson(result));
    } else {
      return BaseModel(status: result['status'], message: result['message']);
    }
  }
}
