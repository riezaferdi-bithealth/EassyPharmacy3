part of engine;

class User extends VmsEngine {
  @override
  String get tag => '';

  // Future<BaseModel<LoginModel>>? login(
  //     String countryCode, String phone, String email) async {
  //   String url = VmsEngine.url! + "/api/public/login";

  //   var uri = Uri.parse(url);

  //   var param;

  //   // if (typeOrigin == DOMESTIC) {
  //   //   param = jsonEncode({"origin": DOMESTIC, "identity_number": "$idNumber"});
  //   // } else {
  //   //   param = jsonEncode(
  //   //       {"origin": INTERNATIONAL, "identity_number": "$passportNumber"});
  //   // }


  //   param = jsonEncode({"country_code": "$countryCode", "phone": "$phone", "email": "$email"});


  //   print("param ${param}");

  //   // var result = await _process(
  //   //   url: uri.toString(),
  //   //   param: param,
  //   //   contentType: ContentType.json,
  //   //   tokenType: TokenType.none,
  //   //   requestType: RequestType.post,
  //   //   processName: "login",
  //   // );

  //   // if (result['code'] == 200) {
  //   //   return BaseModel(
  //   //     code: result['code'],
  //   //     value: LoginModel.fromJson(result),
  //   //   );
  //   // } else {
  //   //   return BaseModel(
  //   //     code: result['code'],
  //   //     value: LoginModel.withError(result),
  //   //   );
  //   // }

  //   await Future.delayed(Duration(seconds: 1));

  //   final response = await rootBundle.loadString('assets/json/login_json.json');
  //   final data = await json.decode(response);

  //   if (data['status'] == true) {
  //     return BaseModel(
  //       status: data['status'],
  //       value: LoginModel.fromJson(data),
  //     );
  //   } else {
  //     return BaseModel(
  //       status: data['status'],
  //       value: LoginModel.fromJson(data),
  //     );
  //   }
  // }




  // // Future<BaseModel<LoginModel>>? loginGoogle(
  // //     String username, String token, String id) async {
  // //   String url = VmsEngine.url! + "/auth/mobile/login/google";
  // //
  // //   var uri = Uri.parse(url);
  // //
  // //   var param = jsonEncode({
  // //     "email": "$username",
  // //     "google_user_id": "$id",
  // //     "device_token": "$token"
  // //   });
  // //
  // //   // print("param ${param}");
  // //
  // //   // await Future.delayed(Duration(seconds: 1));
  // //   var result = await _process(
  // //     url: uri.toString(),
  // //     param: param,
  // //     contentType: ContentType.json,
  // //     tokenType: TokenType.none,
  // //     requestType: RequestType.post,
  // //     processName: "login google",
  // //   );
  // //
  // //   if (result['code'] == 200) {
  // //     return BaseModel(
  // //       code: result['code'],
  // //       value: LoginModel.fromJson(result),
  // //     );
  // //   } else {
  // //     return BaseModel(
  // //       code: result['code'],
  // //       value: LoginModel.withError(result),
  // //     );
  // //   }
  // // }
  // //
  // // Future<BaseModel<LoginModel>>? loginApple(
  // //     String? username, String token, String id) async {
  // //   String url = VmsEngine.url! + "/auth/mobile/login/apple";
  // //
  // //   var uri = Uri.parse(url);
  // //
  // //   var param = jsonEncode({
  // //     "email": username ?? null,
  // //     "apple_user_id": "$id",
  // //     "device_token": token
  // //   });
  // //
  // //   print("param ${param}");
  // //
  // //   // await Future.delayed(Duration(seconds: 1));
  // //   var result = await _process(
  // //     url: uri.toString(),
  // //     param: param,
  // //     contentType: ContentType.json,
  // //     tokenType: TokenType.none,
  // //     requestType: RequestType.post,
  // //     processName: "login apple",
  // //   );
  // //
  // //   if (result['code'] == 200) {
  // //     return BaseModel(
  // //       code: result['code'],
  // //       value: LoginModel.fromJson(result),
  // //     );
  // //   } else {
  // //     return BaseModel(
  // //       code: result['code'],
  // //       value: LoginModel.withError(result),
  // //     );
  // //   }
  // // }
  // //
  // // Future<BaseModel<LoginModel>>? loginPhone(
  // //     String phone, String countryCode, String firebaseToken) async {
  // //   String url = VmsEngine.url! + "/auth/mobile/login/mobile-phone";
  // //   var uri = Uri.parse(url);
  // //   var param = jsonEncode({
  // //     "mobile_phone": "$phone",
  // //     "country_code": "$countryCode",
  // //     "device_token": "$firebaseToken"
  // //   });
  // //
  // //   logger.d("param ${param}");
  // //
  // //   // await Future.delayed(Duration(seconds: 1));
  // //   var result = await _process(
  // //     url: uri.toString(),
  // //     param: param,
  // //     contentType: ContentType.json,
  // //     tokenType: TokenType.none,
  // //     requestType: RequestType.post,
  // //     processName: "login",
  // //   );
  // //
  // //   if (result['code'] == 200) {
  // //     return BaseModel(
  // //       code: result['code'],
  // //       value: LoginModel.fromJson(result),
  // //     );
  // //   } else {
  // //     return BaseModel(
  // //       code: result['code'],
  // //       value: LoginModel.withError(result),
  // //     );
  // //   }
  // // }
  // //
  // // Future<BaseModel<ResponseSubmitModel>> updateDeviceToken(
  // //     {String? deviceToken, BuildContext? context}) async {
  // //   String? isLogin = await AccountHelper.getAuthToken();
  // //
  // //   if (isLogin != null) {
  // //     String url = VmsEngine.url! + "/mobile/user/device-token";
  // //     var uri = Uri.parse(url);
  // //
  // //     var param = jsonEncode({
  // //       "new_device_token": deviceToken,
  // //     });
  // //
  // //     logger.d("yuhu ${param.toString()}");
  // //     var result = await _process(
  // //       url: uri.toString(),
  // //       param: param,
  // //       context: context,
  // //       contentType: ContentType.json,
  // //       tokenType: TokenType.user,
  // //       requestType: RequestType.put,
  // //       processName: "update device token",
  // //     );
  // //
  // //     if (result['code'] == 200) {
  // //       return BaseModel(
  // //         code: result['code'],
  // //         value: ResponseSubmitModel.fromJson(result),
  // //       );
  // //     } else {
  // //       return BaseModel(
  // //         code: result['code'],
  // //         message: result['message'],
  // //       );
  // //     }
  // //   } else {
  // //     return BaseModel();
  // //   }
  // // }
  // //
  // // Future<BaseModel<ResponseSubmitModel>> setBlockUser({String? pin}) async {
  // //   String url = VmsEngine.url! + "/mobile/user/block";
  // //   var uri = Uri.parse(url);
  // //
  // //   // var param = jsonEncode({
  // //   //   "current_pin": pin
  // //   // });
  // //
  // //   // logger.d("yuhu ${param.toString()}");
  // //   var result = await _process(
  // //     url: uri.toString(),
  // //     // param: param,
  // //     contentType: ContentType.json,
  // //     tokenType: TokenType.user,
  // //     requestType: RequestType.post,
  // //     processName: "set block user",
  // //   );
  // //
  // //   if (result['code'] == 200) {
  // //     return BaseModel(
  // //       code: result['code'],
  // //       value: ResponseSubmitModel.fromJson(result),
  // //     );
  // //   } else {
  // //     return BaseModel(
  // //       code: result['code'],
  // //       value: ResponseSubmitModel.fromJson(result),
  // //     );
  // //   }
  // // }

  // //

  // Future<BaseModel<ResponseSubmitModel>> logoutUser({String? pin}) async {
  //   String url = VmsEngine.url! + "/auth/logout";
  //   var uri = Uri.parse(url);

  //   // var param = jsonEncode({
  //   //   "current_pin": pin
  //   // });

  //   // logger.d("yuhu ${param.toString()}");
  //   var result = await _process(
  //     url: uri.toString(),
  //     // param: param,
  //     contentType: ContentType.json,
  //     tokenType: TokenType.user,
  //     requestType: RequestType.post,
  //     processName: "logout user",
  //   );

  //   if (result['status'] == true) {
  //     return BaseModel(
  //       status: result['status'],
  //       value: ResponseSubmitModel.fromJson(result),
  //     );
  //   } else {
  //     return BaseModel(
  //       status: result['status'],
  //       value: ResponseSubmitModel.fromJson(result),
  //     );
  //   }
  // }
}
