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

  Future<BaseModel<ListMedicines>>? getListMedicines() async {
    final response =
        await rootBundle.loadString('assets/json/list_medicines.json');
    final result = await json.decode(response);

    // String url = "${VmsEngine.url!}/api/public/home/list_medicines/";

    // var uri = Uri.parse(url);

    // var result = await _process(
    //   url: uri.toString(),
    //   // param: param,
    //   contentType: ContentType.json,
    //   tokenType: TokenType.none,
    //   requestType: RequestType.get,
    //   processName: "get appbar data",
    // );

    if (result['status'] == true) {
      return BaseModel(
          status: result['status'],
          value: ListMedicines.fromJson(result['data']));
    } else {
      return BaseModel(status: result['status'], message: result['message']);
    }
  }
}
