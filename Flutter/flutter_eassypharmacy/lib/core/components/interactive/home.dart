part of engine;

class Home extends VmsEngine {
  @override
  String get tag => '';

  // Future<BaseModel<ListHomeDataModel>>? getDataHome() async{

  //   String url = VmsEngine.url! + "/api/public/home";

  //   var uri = Uri.parse(url);

  //   var result = await _process(
  //     url: uri.toString(),
  //     // param: param,
  //     contentType: ContentType.json,
  //     tokenType: TokenType.none,
  //     requestType: RequestType.get,
  //     processName: "get home data",
  //   );

  //   if (result['status'] == true) {
  //       return BaseModel(
  //           status: result['status'],
  //           value: ListHomeDataModel.fromJson(result['data'])
  //       );
  //   } else {
  //     return BaseModel(
  //       status: result['status'],
  //       message: result['message']
  //     );
  //   }
  // }

  Future<BaseModel<GetListMedicines>>? getListMedicines(
    String? searchKey
  ) async {
    // final response =
    //     await rootBundle.loadString('assets/json/list_medicines.json');
    // final result = await json.decode(response);

    // http://localhost:3000/drug?search=&page[size]=5&page[number]=1

    String url = "${VmsEngine.url!}/drug?search=$searchKey&page[size]=20";

    var uri = Uri.parse(url);

    var result = await _process(
      url: uri.toString(),
      // param: param,
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
