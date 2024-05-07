// ignore_for_file: invalid_return_type_for_catch_error, unused_element

library engine;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eassypharmacy/core/components/components.dart';
import 'package:flutter_eassypharmacy/feature/features.dart';
import 'package:logger/logger.dart';

part 'home.dart';
part 'register.dart';
part 'login.dart';

const int kLimitPerPage = 10;

enum RequestType { get, delete, post, put }

enum TokenType {
  none,
  login,
  global,
  user,
}

enum ContentType { none, json, urlEncoded, mutipart }

class APIRequest {
  static Home home = Home();
  static Register register = Register();
  static Login login = Login();
}

abstract class VmsEngine {
  String get tag;

  static int maxRetry = 10;
  static Duration timeOutDuration = const Duration(
      milliseconds:
          250000); //dipakai untuk send timeout, receive timeout dan send timeout download
  static Duration?
      timeOutDownloadDuration; //dipakai untuk receive timeout download

  static String? url = application.flavor?.endPoint;
  static String imageUrl = "${application.flavor?.imageEndPoint}";
  static String bannerImage = "/cms";
  static String profileImage = "/profile";
  static String transferReceiptImage = "/transfer";
  static String applicationJson = "application/json";
  static String applicationUrlEncoded = "application/x-www-form-urlencoded";
  static String applicationMultipart = "multipart/form-data";

  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(methodCount: 0),
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  var loggerError = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(
      methodCount: 0,
      lineLength: 5,
    ),
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  static Future<Options> _getDioOptions(BuildContext? context,
      {TokenType? tokenType, String? contentType}) async {
    Map<String, String> header;
    tokenType ??= TokenType.none;
    contentType ??= applicationJson;

    switch (tokenType) {
      case TokenType.login:
        header = await _createHeaderWithTokenLogin(context,
            contentType: contentType);
        break;
      case TokenType.none:
        header = _createHeader(context, contentType: contentType);
        break;
      case TokenType.global:
        header = await _createHeaderWithGlobalToken(context,
            contentType: contentType);
        break;
      case TokenType.user:
        header =
            await _createHeaderWithuserToken(context, contentType: contentType);
        break;
    }

    return Options(
      sendTimeout: timeOutDuration,
      receiveTimeout: timeOutDuration,
      headers: header,
      validateStatus: (statusCode) => statusCode! <= 600,
//      contentType: Headers.jsonContentType,
    );
  }

  static Future<Options> _getDioDownloadOptions(BuildContext? context,
      {TokenType? tokenType, String? contentType}) async {
    Map<String, String> header;
    tokenType ??= TokenType.none;
    contentType ??= applicationJson;
    switch (tokenType) {
      case TokenType.login:
        header = await _createHeaderWithTokenLogin(context,
            contentType: contentType);
        break;
      case TokenType.none:
        header = _createHeader(context, contentType: contentType);
        break;
      case TokenType.global:
        header = await _createHeaderWithGlobalToken(context,
            contentType: contentType);
        break;
      case TokenType.user:
        header =
            await _createHeaderWithuserToken(context, contentType: contentType);
        break;
    }

    return Options(
      sendTimeout: timeOutDuration,
      receiveTimeout: timeOutDownloadDuration,
      headers: header,
      validateStatus: (statusCode) => statusCode == 200,
//      contentType: Headers.jsonContentType,
    );
  }

  static Map<String, String> _createHeader(BuildContext? context,
      {required String contentType}) {
    Map<String, String> header = {};
//    VmsDict dict = VmsDict.of(context);

    if (contentType.isNotEmpty) {
      header.putIfAbsent("content-type", () => contentType);
    }
//    header.putIfAbsent("x-localization", () => dict.locale.languageCode);

    return header;
  }

  static Future<Map<String, String>> _createHeaderWithTokenLogin(
      BuildContext? context,
      {required String contentType}) async {
    Map<String, String> header = {};

    if (contentType.isNotEmpty) {
      header.putIfAbsent("content-type", () => contentType);
    }

    String? token = await AccountHelper.getAuthToken();

    header.putIfAbsent("token", () => "$token");

    return header;
  }

  static Future<Map<String, String>> _createHeaderWithGlobalToken(
      BuildContext? context,
      {required String contentType}) async {
    Map<String, String> header = {};

    if (contentType.isNotEmpty) {
      header.putIfAbsent("content-type", () => contentType);
    }

    header.putIfAbsent(
        "Authorization", () => "Bearer ${application.flavor?.globalToken}");

    return header;
  }

  static Future<Map<String, String>> _createHeaderWithuserToken(
      BuildContext? context,
      {required String contentType}) async {
    Map<String, String> header = {};

    String? userToken = await AccountHelper.getAuthToken();

    if (contentType.isNotEmpty) {
      header.putIfAbsent("content-type", () => contentType);
    }

    header.putIfAbsent("Authorization", () => "Bearer $userToken");

    return header;
  }

  bool handleSuccess(BuildContext context, var result) {
    if (result is Map && result["success"] != null) {
      return result["success"];
    }

    return false;
  }

  handlePayloadData(var result) {
    if (result["payload"] != null) {
      if (result["payload"]["data"] != null) {
        return result["payload"]["data"];
      }
    } else {
      if (result["error"] != null) {
        if (result["error"]["message"] != null) {
          return null;
        } else if (result["error"]["code"] != null) {
          return null;
        }
      }
    }

    return null;
  }

  handleData(BuildContext context, var result) {
    if (result["data"] != null) {
      return result["data"];
    } else {
      if (result["errors"] != null) {
        if (result["errors"] is List && result["errors"].length > 0) {
          return null;
        }
      }
    }

    return null;
  }

  Future<Response<dynamic>?> _handleError(
    context,
    counter,
    refreshCounter,
    DioException error,
    url,
    CancelToken token,
    TokenType tokenType,
    RequestType requestType, {
    var param,
  }) async {
    loggerError.e("Message => ${error.message}");
    loggerError.e("Error => ${error.error}");
    loggerError.e("Type => ${error.type}");
    loggerError.e("Request => ${error.requestOptions.toString()}");
    loggerError.e("Response => ${error.response}");
    loggerError.e("Url => $url");

    // logger.d("Message => ${error.message}");
    // logger.d("Error => ${error.error}");
    // logger.d("Type => ${error.type}");
    // logger.d("Request => ${error.requestOptions.toString()}");
    // logger.d("Response => ${error.response}");
    // logger.d("Url => $url");

    //VmsDict dict = VmsDict.of(context);

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      if (counter < maxRetry) {
        counter++;
        Toast.showToast(context, "Request Timed Out ($counter)",
            duration: const Duration(seconds: 5));

        if (requestType == RequestType.post) {
          return await _post(
            context: context,
            url: url,
            param: param,
            lastCounter: counter,
            refreshCounter: refreshCounter,
            token: token,
            tokenType: tokenType,
          );
        } else if (requestType == RequestType.put) {
          return await _put(
            context: context,
            url: url,
            param: param,
            lastCounter: counter,
            refreshCounter: refreshCounter,
            token: token,
            tokenType: tokenType,
          );
        } else if (requestType == RequestType.get) {
          return await _get(
            context: context,
            url: url,
            lastCounter: counter,
            refreshCounter: refreshCounter,
            token: token,
            tokenType: tokenType,
          );
        } else if (requestType == RequestType.delete) {
          return await _delete(
            context: context,
            url: url,
            lastCounter: counter,
            refreshCounter: refreshCounter,
            token: token,
            tokenType: tokenType,
          );
        }
      } else {
        Toast.showToast(
            context, "Request timed out after attempt to connect 10 times!",
            duration: const Duration(seconds: 5));

        return null;
      }
    } else {
      if (CancelToken.isCancel(error)) {
        Toast.showToast(context, "Request Canceled: ${error.message}",
            duration: const Duration(seconds: 5));
        return null;
      } else {
        if (error.response?.statusCode != null &&
            error.response?.statusCode == 401) {
          if (error.response != null) {
            if (error.response?.data is Map &&
                (error.response?.data as Map)["errors"] != null) {
              if ((error.response?.data as Map)["errors"] is List) {
                List rawErrors =
                    (error.response?.data as Map)["errors"] as List;
                if (rawErrors.isNotEmpty &&
                    (rawErrors.first == "Invalid token!" ||
                        rawErrors.first == "Your session has been expired!")) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: const Text('Informasi'),
                        content: Text(
                          rawErrors.first,
                        ),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          TextButton(
                            child: const Text('Tutup'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  ).then((_) async {
                    /*  await AccountHelper.signOut();
                   Routing.pushAndRemoveUntil(
                       context, LoginPage(), (_) => false);*/
                  });

                  return null;
                }
              }
            }
          }
        }

        // ignore: unused_local_variable
        String? errorMessage = error.message;

        if (error.response != null) {
          if (error.response?.data is Map &&
              (error.response?.data as Map)["errors"] != null) {
            if ((error.response?.data as Map)["errors"] is List) {
              List rawErrors = (error.response?.data as Map)["errors"] as List;
              errorMessage = rawErrors.join("\n");
            }
          }
        }

        // Toast.showToast(context, "Error: $errorMessage", duration: Duration(seconds: 5));
        return null;
      }
    }

    return null;
  }

  Future<Response<dynamic>?> _handleDownloadError(
    context,
    counter,
    refreshCounter,
    DioException error,
    url,
    savePath,
    token,
    TokenType tokenType,
  ) async {
    loggerError.e("Message => ${error.message}");
    loggerError.e("Error => ${error.error}");
    loggerError.e("Type => ${error.type}");
    loggerError.e("Request => ${error.requestOptions.toString()}");
    loggerError.e("Response => ${error.response}");
    loggerError.e("Url => $url");

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      logger.d("compare count => $counter < $maxRetry");
      if (counter < maxRetry) {
        counter++;
        Toast.showToast(context, "Request Timed Out ($counter)");

        bool x = await _download(
          savePath: savePath,
          context: context,
          url: url,
          lastCounter: counter,
          refreshCounter: refreshCounter,
          token: token,
          tokenType: tokenType,
        );

        return Response(data: x, requestOptions: error.requestOptions);
      } else {
        // Toast.showToast(
        //     context, "Request timed out after attempt to connect 10 times!");
        return Response(data: false, requestOptions: error.requestOptions);
      }
    } else {
      if (CancelToken.isCancel(error)) {
        // Toast.showToast(context, "Request Canceled: ${error.message}");
        return Response(data: false, requestOptions: error.requestOptions);
      } else {
        // Toast.showToast(context, "Error: ${error.message}");
        return Response(data: false, requestOptions: error.requestOptions);
      }
    }
  }

  Future _post({
    BuildContext? context,
    required String url,
    var param,
    int? lastCounter,
    int? refreshCounter,
    CancelToken? token,
    TokenType tokenType = TokenType.none,
    ContentType? contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? applicationJson
        : contentType == ContentType.urlEncoded
            ? applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? applicationMultipart
                : "";

    var options = await _getDioOptions(context,
        tokenType: tokenType, contentType: contentTypeString);

    var result = await dio.post<dynamic>(
      url,
      data: param,
      options: options,
      cancelToken: token,
      onSendProgress: (int sent, int total) {
        logger.d("$sent $total");
      },
    ).catchError((error) {
      // logger.d("Options ${options.headers}");
      // logger.d("Param $param");
      // logger.d("Error lagi $error");
      return _handleError(context, counter, refreshCounter, error, url, token!,
          tokenType, RequestType.post,
          param: param);
    });

    return result;
  }

  Future _put({
    BuildContext? context,
    required String url,
    var param,
    int? lastCounter,
    int? refreshCounter,
    CancelToken? token,
    TokenType tokenType = TokenType.none,
    ContentType? contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? applicationJson
        : contentType == ContentType.urlEncoded
            ? applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? applicationMultipart
                : "";

    var options = await _getDioOptions(context,
        tokenType: tokenType, contentType: contentTypeString);

    // logger.d('paramput $param');

    var result = await dio.put<dynamic>(
      url,
      data: param,
      options: options,
      cancelToken: token,
      onSendProgress: (int sent, int total) {
        logger.d("$sent $total");
      },
    ).catchError((error) {
      return _handleError(context, counter, refreshCounter, error, url, token!,
          tokenType, RequestType.put,
          param: param);
    });

    return result;
  }

  Future _get({
    BuildContext? context,
    required String url,
    int? lastCounter,
    int? refreshCounter,
    CancelToken? token,
    TokenType tokenType = TokenType.none,
    ContentType? contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? applicationJson
        : contentType == ContentType.urlEncoded
            ? applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? applicationMultipart
                : "";

    var options = await _getDioOptions(context,
        tokenType: tokenType, contentType: contentTypeString);
    var result = await dio.get<dynamic>(url,
        options: options,
        cancelToken: token, onReceiveProgress: (int sent, int total) {
      logger.d("$sent $total");
    }).catchError((error) {
      return _handleError(context, counter, refreshCounter, error, url, token!,
          tokenType, RequestType.put);
    });

    return result;
  }

  Future _delete({
    BuildContext? context,
    required String url,
    int? lastCounter,
    int? refreshCounter,
    CancelToken? token,
    TokenType tokenType = TokenType.none,
    ContentType? contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? applicationJson
        : contentType == ContentType.urlEncoded
            ? applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? applicationMultipart
                : "";

    var options = await _getDioOptions(context,
        tokenType: tokenType, contentType: contentTypeString);

    var result = await dio
        .delete<dynamic>(url, options: options, cancelToken: token)
        .catchError((error) async {
      return _handleError(
        context,
        counter,
        refreshCounter,
        error,
        url,
        token!,
        tokenType,
        RequestType.delete,
      );
    });

    return result;
  }

  Future<bool> _download({
    BuildContext? context,
    required String url,
    required String savePath,
    int? lastCounter,
    int? refreshCounter,
    CancelToken? token,
    TokenType tokenType = TokenType.none,
    ContentType? contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? applicationJson
        : contentType == ContentType.urlEncoded
            ? applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? applicationMultipart
                : "";

    var options = await _getDioDownloadOptions(context,
        tokenType: tokenType, contentType: contentTypeString);
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    } as CreateHttpClient?;
    logger.d(url);

    var result = await dio.download(url, savePath,
        options: options, cancelToken: token, onReceiveProgress: (rec, total) {
      // logger.d(" Progress Precentage ${(rec / total * 100).toStringAsFixed(0)} %");
      logger.d(" 1 1 Rec: $rec , Total: $total");
    }).catchError((error) async {
      return _handleDownloadError(
        context,
        counter,
        refreshCounter,
        error,
        url,
        savePath,
        token,
        tokenType,
      );
    });

    // print("result ${result.toString()}");

    return result.statusCode == 200;
  }

  Future _process({
    BuildContext? context,
    required String url,
    var param,
    int? lastCounter,
    int? refreshCounter,
    CancelToken? token,
    TokenType tokenType = TokenType.none,
    required RequestType requestType,
    ContentType? contentType,
    required String processName,
  }) async {
    dynamic result;

    if (requestType == RequestType.post) {
      result = await _post(
        context: context,
        url: url,
        param: param,
        lastCounter: lastCounter,
        refreshCounter: refreshCounter,
        token: token,
        tokenType: tokenType,
        contentType: contentType,
      );
    } else if (requestType == RequestType.put) {
      result = await _put(
        context: context,
        url: url,
        param: param,
        lastCounter: lastCounter,
        refreshCounter: refreshCounter,
        token: token,
        tokenType: tokenType,
        contentType: contentType,
      );
    } else if (requestType == RequestType.get) {
      result = await _get(
        context: context,
        url: url,
        lastCounter: lastCounter,
        refreshCounter: refreshCounter,
        token: token,
        tokenType: tokenType,
        contentType: contentType,
      );
    } else if (requestType == RequestType.delete) {
      result = await _delete(
        context: context,
        url: url,
        lastCounter: lastCounter,
        refreshCounter: refreshCounter,
        token: token,
        tokenType: tokenType,
        contentType: contentType,
      );
    }

    try {
      if (result.statusCode != 403) {
        logger.d("$processName from: $url");
        logger.d(result.data);
      }
      // else if (result.statusCode == 401 || result.statusCode == 402) {
      //   loggerError.e("Endpoint $processName : $url");
      //   loggerError.e("Data : ${result?.data ?? ""}");
      //   // loggerError.e("Msg : ${result.data['message'][0]}");
      //   //tabIndex.value = 0;
      //   showDialog<String>(
      //     context: context!,
      //     barrierDismissible: false,
      //     builder: (BuildContext context) {
      //       String title = "session_end";
      //       String message = "please_login";
      //       //String btnLabel = "Update Sekarang";
      //       return WillPopScope(
      //           onWillPop: null,
      //           child: AlertDialog(
      //             title:
      //                 Center(child: Text(title, style: p16.semiBold.primary)),
      //             content: Text(
      //               message,
      //               style: p12,
      //               textAlign: TextAlign.center,
      //             ),
      //             actions: <Widget>[
      //               Container(
      //                 margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      //                 child: GeneralButton.text(
      //                   'Ok',
      //                   //height: 42,
      //                   padding: EdgeInsets.symmetric(vertical: 6),
      //                   backgroundColor: systemPrimaryColor,
      //                   buttonSize: ButtonSize.large,
      //                   width: double.infinity,
      //                   circular: 10,
      //                   onPressed: () {
      //                     context!
      //                         .read<AuthenticationCubit>()
      //                         .logoutWithoutHitApi();
      //                     Routing.pushAndRemoveUntil(
      //                         context!, InitContainer(), (route) => false);
      //                   },
      //                 ),
      //               ),
      //             ],
      //           ));
      //     },
      //   );
      // }
      else {
        loggerError.e("$processName from: $url");
        loggerError.e(result.data);
      }
    } catch (e) {
      loggerError.e("Catch error: ${e.toString()}");
    }

    if (result == null) return null;

    return result.data;
  }

  Future _getToken({
    BuildContext? context,
    required String url,
    var param,
    int? lastCounter,
    int? refreshCounter,
    CancelToken? token,
    TokenType tokenType = TokenType.none,
    ContentType? contentType,
  }) async {
    int counter = lastCounter ?? 0;
    refreshCounter ??= 0;

    Dio dio = Dio();

    token ??= CancelToken();
    contentType ??= ContentType.json;

    String contentTypeString = contentType == ContentType.json
        ? applicationJson
        : contentType == ContentType.urlEncoded
            ? applicationUrlEncoded
            : contentType == ContentType.mutipart
                ? applicationMultipart
                : "";

    var options = await _getDioOptions(context,
        tokenType: tokenType, contentType: contentTypeString);

    var result = await dio.post<dynamic>(
      url,
      data: param,
      options: options,
      cancelToken: token,
      onSendProgress: (int sent, int total) {
        logger.d("$sent $total");
      },
    ).catchError((error) {
      // logger.d("Options ${options.headers}");
      // logger.d("Param $param");
      // logger.d("Error lagi $error");
      return _handleError(context, counter, refreshCounter, error, url, token!,
          tokenType, RequestType.post,
          param: param);
    });

    return result;
  }
}
