import 'dart:convert';
import 'dart:io';

import 'package:ifloriana/configs.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/auth/auth_repository.dart';
import '../screens/auth/view/sign_in_screen.dart';
import '../utils/api_end_points.dart';
import '../utils/app_common.dart';
import '../utils/constants.dart';
import '../utils/model_keys.dart';

Map<String, String> buildHeaderTokens({
  Map? extraKeys,
  String? endPoint,
}) {
  /// Initialize & Handle if key is not present
  if (extraKeys == null) {
    extraKeys = {};
    extraKeys.putIfAbsent('isStripePayment', () => false);
    extraKeys.putIfAbsent('isFlutterWave', () => false);
  }

  Map<String, String> header = {
    HttpHeaders.cacheControlHeader: 'no-cache',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Origin': '*',
    'frezka-localization': appStore.selectedLanguageCode,
  };

  if (endPoint == APIEndPoints.register) {
    header.putIfAbsent(HttpHeaders.acceptHeader, () => 'application/json');
  }

  header.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');

  if (appStore.isLoggedIn && extraKeys.containsKey('isStripePayment') && extraKeys['isStripePayment']) {
    header.putIfAbsent(HttpHeaders.acceptHeader, () => 'application/x-www-form-urlencoded');
    header[HttpHeaders.contentTypeHeader] = 'application/x-www-form-urlencoded';
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer ${extraKeys!['stripeKeyPayment']}');
  } else if (appStore.isLoggedIn && extraKeys.containsKey('isFlutterWave') && extraKeys['isFlutterWave']) {
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => "Bearer ${extraKeys!['flutterWaveSecretKey']}");
  } else if (appStore.isLoggedIn) {
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer ${userStore.token}');
  }

  log(jsonEncode(header));
  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$BASE_URL$endPoint');

  // log('URL: ${url.toString()}');

  return url;
}

Map<String, String> buildHeaderForSadad({String? sadadToken}) {
  Map<String, String> header = defaultHeaders();

  header.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json');
  if (sadadToken != null) header.putIfAbsent(HttpHeaders.authorizationHeader, () => sadadToken);

  return header;
}

Future<Response> buildHttpResponse(
  String endPoint, {
  HttpMethodType method = HttpMethodType.GET,
  Map? request,
  Map? extraKeys,
  Map<String, String>? header,
}) async {
  if (await isNetworkAvailable()) {
    var headers = header ?? buildHeaderTokens(extraKeys: extraKeys, endPoint: endPoint);
    Uri url = buildBaseUrl(endPoint);

    Response response;

    if (method == HttpMethodType.POST) {
      // log('Request: ${jsonEncode(request)}');
      response = await http.post(url, body: jsonEncode(request), headers: headers).timeout(Duration(seconds: 20));
    } else if (method == HttpMethodType.DELETE) {
      response = await delete(url, headers: headers).timeout(Duration(seconds: 20));
    } else if (method == HttpMethodType.PUT) {
      response = await put(url, body: jsonEncode(request), headers: headers).timeout(Duration(seconds: 20));
    } else {
      response = await get(url, headers: headers).timeout(Duration(seconds: 20));
    }

    // log('Response (${method.name}) ${response.statusCode}: ${response.body.trim()}');

    apiPrint(
      url: url.toString(),
      endPoint: endPoint,
      headers: jsonEncode(headers),
      hasRequest: method == HttpMethodType.POST || method == HttpMethodType.PUT,
      request: jsonEncode(request),
      statusCode: response.statusCode,
      responseBody: response.body.trim(),
      methodtype: method.name,
    );

    if (appStore.isLoggedIn && response.statusCode == 401) {
      return await reGenerateToken().then((value) async {
        return await buildHttpResponse(endPoint, method: method, request: request, extraKeys: extraKeys);
      }).catchError((e) {
        throw errorSomethingWentWrong;
      });
    } else {
      return response;
    }
  } else {
    throw errorInternetNotAvailable;
  }
}

Future handleResponse(Response response, {HttpResponseType httpResponseType = HttpResponseType.JSON, bool? avoidTokenError, bool? isFlutterWave}) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }

  if (response.statusCode.isSuccessful()) {
    if (response.body.isJson()) {
      Map body = jsonDecode(response.body);

      if (body.containsKey('status')) {
        if (isFlutterWave.validate()) {
          if (body['status'] == 'success') {
            return body;
          } else {
            throw body['message'] ?? errorSomethingWentWrong;
          }
        } else {
          if (body['status']) {
            return body;
          } else {
            throw body['message'] ?? errorSomethingWentWrong;
          }
        }
      } else {
        return body;
      }
    } else {
      throw errorSomethingWentWrong;
    }
  } else if (response.statusCode == 401) {
    await clearData(clearBranchData: false);
    push(SignInScreen(), isNewTask: true);
    throw '${locale.tokenExpired}';
  } else if (response.statusCode == 400) {
    throw '${locale.badRequest}';
  } else if (response.statusCode == 403) {
    throw '${locale.forbidden}';
  } else if (response.statusCode == 404) {
    throw '${locale.pageNotFound}';
  } else if (response.statusCode == 429) {
    throw '${locale.tooManyRequests}';
  } else if (response.statusCode == 500) {
    throw '${locale.internalServerError}';
  } else if (response.statusCode == 502) {
    throw '${locale.badGateway}';
  } else if (response.statusCode == 503) {
    throw '${locale.serviceUnavailable}';
  } else if (response.statusCode == 504) {
    throw '${locale.gatewayTimeout}';
  } else {
    if (response.body.isJson()) {
      Map body = jsonDecode(response.body);

      if (body.containsKey('status')) {
        if (body['status']) {
          return body;
        } else {
          throw body['message'] ?? errorSomethingWentWrong;
        }
      } else {
        return body;
      }
    } else {
      throw errorSomethingWentWrong;
    }
  }
}

//region airtel money
Map<String, String> buildHeaderForAirtelMoney(String accessToken, String XCountry, String XCurrency) {
  Map<String, String> header = defaultHeaders();

  header.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');
  header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer $accessToken');
  header.putIfAbsent('X-Country', () => '$XCountry');
  header.putIfAbsent('X-Currency', () => '$XCurrency');

  return header;
}

Map<String, String> defaultHeaders() {
  Map<String, String> header = {};

  header.putIfAbsent(HttpHeaders.cacheControlHeader, () => 'no-cache');
  header.putIfAbsent('Access-Control-Allow-Headers', () => '*');
  header.putIfAbsent('Access-Control-Allow-Origin', () => '*');

  return header;
}
//endregion

Future<void> reGenerateToken() async {
  log('Regenerating Token');
  Map req = {
    CommonKey.email: getStringAsync(SharedPreferenceConst.USER_EMAIL),
    if (isLoginTypeUser) CommonKey.password: getStringAsync(SharedPreferenceConst.USER_PASSWORD),
    if (!isLoginTypeUser) CommonKey.profileImage: getStringAsync(SharedPreferenceConst.PROFILE_IMAGE),
    if (!isLoginTypeUser) CommonKey.loginType: getStringAsync(SharedPreferenceConst.USER_TYPE),
  };

  return await loginUser(req, isSocialLogin: !isLoginTypeUser, isRegenerateToken: true).then((value) async {
    //
  }).catchError((e) {
    throw e;
  });
}

Future<MultipartRequest> getMultiPartRequest(String endPoint, {String? baseUrl}) async {
  String url = '${baseUrl ?? buildBaseUrl(endPoint).toString()}';
  log(url);
  return MultipartRequest('POST', Uri.parse(url));
}

Future<void> sendMultiPartRequest(MultipartRequest multiPartRequest, {Function(dynamic)? onSuccess, Function(dynamic)? onError}) async {
  http.Response response = await http.Response.fromStream(await multiPartRequest.send());
  apiPrint(
      url: multiPartRequest.url.toString(),
      headers: jsonEncode(multiPartRequest.headers),
      request: jsonEncode(multiPartRequest.fields),
      hasRequest: true,
      statusCode: response.statusCode,
      responseBody: response.body,
      methodtype: "MultiPart");
  if (response.statusCode.isSuccessful()) {
    onSuccess?.call(response.body);
  } else {
    onError?.call(errorSomethingWentWrong);
  }
}

Future<List<MultipartFile>> getMultipartImages2({required List<XFile> files, required String name}) async {
  List<MultipartFile> multiPartRequest = [];

  await Future.forEach<XFile>(files, (element) async {
    int i = files.indexOf(element);

    multiPartRequest.add(await MultipartFile.fromPath('$name[${i.toString()}]', element.path.validate()));
    log('MultipartFile: $name[${i.toString()}]');
  });

  return multiPartRequest;
}

String parseStripeError(String response) {
  try {
    var body = jsonDecode(response);
    return parseHtmlString(body['error']['message']);
  } on Exception catch (e) {
    log(e);
    throw errorSomethingWentWrong;
  }
}

Future<Map<String, dynamic>> handleSadadResponse(Response res) async {
  if (res.body.isJson()) {
    var body = jsonDecode(res.body);

    if (res.statusCode.isSuccessful()) {
      return body;
    } else {
      throw parseHtmlString(body['error']['message']);
    }
  } else {
    throw errorSomethingWentWrong;
  }
}

void apiPrint({
  String url = "",
  String endPoint = "",
  String headers = "",
  String request = "",
  int statusCode = 0,
  String responseBody = "",
  String methodtype = "",
  bool hasRequest = false,
}) {
  log("┌───────────────────────────────────────────────────────────────────────────────────────────────────────");
  log("\u001b[93m Url: \u001B[39m $url");
  log("\u001b[93m endPoint: \u001B[39m \u001B[1m$endPoint\u001B[22m");
  log("\u001b[93m header: \u001B[39m \u001b[96m$headers\u001B[39m");
  if (hasRequest) {
    log('\u001b[93m Request: \u001B[39m \u001b[95m$request\u001B[39m');
  }
  log("${statusCode.isSuccessful() ? "\u001b[32m" : "\u001b[31m"}");
  log('Response ($methodtype) $statusCode: $responseBody');
  log("\u001B[0m");
  log("└───────────────────────────────────────────────────────────────────────────────────────────────────────");
}
