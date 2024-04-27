part of engine;

class Register extends VmsEngine {
  @override
  String get tag => '';


  // Future<BaseModel<RegisterModel>>? submitRegister(
  //     String? fullName,
  //     String? idNumber,
  //     String? passportNumber,
  //     String? dob,
  //     String? sex,
  //     String? phoneNumber,
  //     String? countryCode,
  //     String? email,
  //     int? typeOrigin,
  //     ) async {
  //   String url = VmsEngine.url! + "/api/public/registration";

  //   var uri = Uri.parse(url);

  //   var param;

  //   if (typeOrigin == DOMESTIC) {
  //     param = jsonEncode({
  //       "fullname": "$fullName",
  //       "ktp_number": "$idNumber",
  //       "passport_number": "",
  //       "phone": "$phoneNumber",
  //       "country_code": "$countryCode",
  //       "email": "$email",
  //       "dob": "$dob",
  //       "sex": "$sex",
  //       "origin": DOMESTIC,
  //       "is_newsletter" : true
  //     });
  //   } else {
  //     param = jsonEncode({
  //       "fullname": "$fullName",
  //       "ktp_number": "",
  //       "passport_number": "$passportNumber",
  //       "phone": "$phoneNumber",
  //       "country_code": "$countryCode",
  //       "email": "$email",
  //       "dob": "$dob",
  //       "sex": "$sex",
  //       "origin": INTERNATIONAL,
  //       "is_newsletter" : true
  //     });
  //   }

  //   print("param ${param}");

  //   var result = await _process(
  //     url: uri.toString(),
  //     param: param,
  //     contentType: ContentType.json,
  //     tokenType: TokenType.none,
  //     requestType: RequestType.post,
  //     processName: "submit register",
  //   );

  //   if (result['status'] == true) {
  //     return BaseModel(
  //       status: result['status'],
  //       value: result['data'] != null ? RegisterModel.fromJson(result['data']) : null,
  //     );
  //   } else {
  //     return BaseModel(
  //       status: result['status'],
  //       message: result['message'],
  //     );
  //   }

  //   // await Future.delayed(Duration(seconds: 1));
  //   //
  //   // final response =
  //   // await rootBundle.loadString('assets/json/register_submit_json.json');
  //   // final data = await json.decode(response);
  //   //
  //   // if (data['status'] == true) {
  //   //   return BaseModel(
  //   //     status: data['status'],
  //   //     value: Register.fromJson(data),
  //   //   );
  //   // } else {
  //   //   return BaseModel(
  //   //     status: data['status'],
  //   //     value: Register.fromJson(data),
  //   //   );
  //   // }
  // }


  // Future<BaseModel<RequsetOtpModel>>? sendOtp(
  //     String? email,
  //     String? phoneNumber,
  //     String? countryCode,
  //     int? type,
  //     String? otpType
  //     ) async {
  //   String url = VmsEngine.url! + "/api/public/otps/request";

  //   var uri = Uri.parse(url);

  //   var param;

  //   print("email ${param}");
  //   print("phone ${param}");
  //   print("otpType ${otpType.toString()}");


  //   param = jsonEncode({
  //     "email": otpType == EMAIL ? email : "",
  //     "phone": otpType == PHONE_NUMBER ? phoneNumber : "",
  //     "country_code": "$countryCode",
  //     "type": type
  //   });

  //   print("param ${param}");

  //   var result = await _process(
  //     url: uri.toString(),
  //     param: param,
  //     contentType: ContentType.json,
  //     tokenType: TokenType.none,
  //     requestType: RequestType.post,
  //     processName: "request otp login",
  //   );

  //   if (result['status'] == true) {
  //     return BaseModel(
  //       status: result['status'],
  //       value: RequsetOtpModel.fromJson(result['data'], result['code'] ?? ""),
  //     );
  //   } else {

  //     return BaseModel(
  //       status: result['status'],
  //       value: result['data'] != null ? RequsetOtpModel.fromJson(result['data'], result['code']) : RequsetOtpModel.fromJsonNull(null, result['code']),
  //       message: result['message']
  //     );
  //   }

  //   // await Future.delayed(Duration(seconds: 1));
  //   //
  //   // final response = await rootBundle.loadString(
  //   //     'assets/json/request_otp_register_json.json'); //not final json
  //   // final data = await json.decode(response);
  //   //
  //   // if (data['status'] == true) {
  //   //   return BaseModel(
  //   //     status: data['status'],
  //   //     value: Request.fromJson(data),
  //   //   );
  //   // } else {
  //   //   return BaseModel(
  //   //     status: data['status'],
  //   //     value: Request.fromJson(data),
  //   //   );
  //   // }
  // }


  // Future<BaseModel<VerifyOtpModel>>? verifyOtp(
  //     String? email,
  //     String? phoneNumber,
  //     String? countryCode,
  //     // String? dob,
  //     // String? sex,
  //     String? otp,
  //     String? mobileFcmToken,
  //     int? type,
  //     ) async {
  //   String url = VmsEngine.url! + "/api/public/otps/verify";

  //   var uri = Uri.parse(url);

  //   var param;

  //   param = jsonEncode({
  //     "email": type == REGISTER ? "" : type == LOGIN ? email ?? "" : "",
  //     "phone": "$phoneNumber",
  //     "country_code": "$countryCode",
  //     // "dob": "$dob",
  //     // "sex": "$sex",
  //     "otp": "$otp",
  //     "mobile_fcm_token": "$mobileFcmToken",
  //     "type": type,
  //   });

  //   print("param ${param}");

  //   var result = await _process(
  //     url: uri.toString(),
  //     param: param,
  //     contentType: ContentType.json,
  //     tokenType: TokenType.none,
  //     requestType: RequestType.post,
  //     processName: "otp type (${type.toString()})",
  //   );

  //   if (result['status'] == true) {
  //     return BaseModel(
  //       status: result['status'],
  //       value: VerifyOtpModel.fromJson(result['data']),
  //     );
  //   } else {
  //     return BaseModel(
  //       status: result['status'],
  //       message: result['message']
  //     );
  //   }

  //   // await Future.delayed(Duration(seconds: 1));
  //   //
  //   // final response = await rootBundle.loadString(
  //   //     'assets/json/verify_otp_register_json.json'); //not final json
  //   // final data = await json.decode(response);
  //   //
  //   // if (data['status'] == true) {
  //   //   return BaseModel(
  //   //     status: data['status'],
  //   //     value: Verify.fromJson(data),
  //   //   );
  //   // } else {
  //   //   return BaseModel(
  //   //     status: data['status'],
  //   //     value: Verify.fromJson(data),
  //   //   );
  //   // }
  // }
}



