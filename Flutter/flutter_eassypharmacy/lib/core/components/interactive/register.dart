part of engine;

class Register extends VmsEngine {
  @override
  String get tag => '';

  Future<BaseModel<RegisterModel>>? submitRegister(
    String? fullName,
    // String? idNumber,
    String? phoneNumber,
    String? password,
    String? email,
  ) async {
    // final response =
    //     await rootBundle.loadString('assets/json/register.json');
    // final result = await json.decode(response);

    String url = "${VmsEngine.url!}/user/register";

    var uri = Uri.parse(url);

    var param = jsonEncode({
      "fullname": fullName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
    });

    print("param ${param}");

    var result = await _process(
      url: uri.toString(),
      param: param,
      contentType: ContentType.json,
      tokenType: TokenType.none,
      requestType: RequestType.post,
      processName: "submit register",
    );

    if (result['status'] == true) {
      return BaseModel(
        status: result['status'],
        value: result['data'] != null ? RegisterModel.fromJson(result) : null,
      );
    } else {
      return BaseModel(
        status: result['status'],
        message: result['message'],
      );
    }
  }
}
