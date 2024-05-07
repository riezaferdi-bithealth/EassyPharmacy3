part of engine;

class Login extends VmsEngine {
  @override
  String get tag => '';

  Future<BaseModel<LoginModel>>? submitLogin(
    // String? phoneNumber,
    String? email,
    String? password,
  ) async {
    final response =
        await rootBundle.loadString('assets/json/login.json');
    final result = await json.decode(response);
    // String url = VmsEngine.url! + "/api/public/registration";

    // var uri = Uri.parse(url);

    var param = jsonEncode({
       // "phone_number": phoneNumber,
      "email": email,
      "password": password,
    });

    // print("param ${param}");

    // var result = await _process(
    //   url: uri.toString(),
    //   param: param,
    //   contentType: ContentType.json,
    //   tokenType: TokenType.none,
    //   requestType: RequestType.post,
    //   processName: "submit Login",
    // );

    if (result['status'] == true) {
      return BaseModel(
        status: result['status'],
        value:
            result['data'] != null ? LoginModel.fromJson(result) : null,
      );
    } else {
      return BaseModel(
        status: result['status'],
        message: result['message'],
      );
    }
  }
}
