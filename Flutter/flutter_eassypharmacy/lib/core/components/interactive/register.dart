part of engine;

class Register extends VmsEngine {
  @override
  String get tag => '';

  Future<BaseModel<RegisterModel>>? submitRegister(
    String? fullName,
    String? phoneNumber,
    String? password,
    String? email,
  ) async {

    String url = "${VmsEngine.url!}/user/register";

    var uri = Uri.parse(url);

    var param = jsonEncode({
      "fullname": fullName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
    });

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
        message: result['message'],
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
