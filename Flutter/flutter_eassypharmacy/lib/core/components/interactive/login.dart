part of engine;

class Login extends VmsEngine {
  @override
  String get tag => '';

  Future<BaseModel<LoginModel>>? submitLogin(
    String? email,
    String? password,
  ) async {
    String url = "${VmsEngine.url!}/user/login";

    var uri = Uri.parse(url);

    var param = jsonEncode({
      "email": email,
      "password": password,
    });

    var result = await _process(
      url: uri.toString(),
      param: param,
      contentType: ContentType.json,
      tokenType: TokenType.none,
      requestType: RequestType.post,
      processName: "submit Login",
    );

    if (result['status'] == true) {
      return BaseModel(
        status: result['status'],
        message: result['message'],
        value: result != null ? LoginModel.fromJson(result) : null,
      );
    } else {
      return BaseModel(
        status: result['status'],
        message: result['message'],
      );
    }
  }
}
