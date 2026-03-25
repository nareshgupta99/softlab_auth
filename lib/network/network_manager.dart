import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:softlab_auth/constants/app_constant.dart';
import 'package:softlab_auth/constants/keys.dart';
import 'package:softlab_auth/utils/local_storage.dart';
import 'package:softlab_auth/network/network_endpoint.dart';
import 'package:softlab_auth/network/network_exception.dart';
import 'package:softlab_auth/network/network_resources.dart';

class NetworkManager extends GetxService {
  final int _timeoutInSeconds = 60;
  Map<String, String> _requestCurl = {};
  final _baseURL = AppConstant.baseUrl;

  void networkRequestCurlWith({String? token}) {
    _requestCurl = {
      'charset': 'UTF-8',
      'Charset': 'utf-8',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': 'true',
    };
    if (token != null) {
      _requestCurl.addAll({'Authorization': 'Bearer $token'});
    }
    final requestCurlTree = const JsonEncoder.withIndent('  ').convert(_requestCurl);
    print('Request curl :: $requestCurlTree');
  }

  Future<dynamic> loadHTTP({
    required Endpoints endpoint,
    String? slashedQuery,
    required HTTPMethod method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? multipartPayload,
    List<MultipartFiles>? multipartFiles,
  }) async {
    final url =
        slashedQuery != null
            ? Uri.parse(_baseURL + endpointRawValues[endpoint]! + slashedQuery).replace(queryParameters: queryParameters)
            : Uri.parse(_baseURL + endpointRawValues[endpoint]!).replace(queryParameters: queryParameters);
    print('Request url :: $url');
    print('Endpoint :: ${endpointRawValues[endpoint]!}');
    final bearerToken = await LocalStorage.getStringData(key: Keys.bearerToken);
    print('Bearer token :: ${bearerToken ?? 'Not Authorized'}');

    networkRequestCurlWith(token: bearerToken);

    final payloadTree = const JsonEncoder.withIndent('  ').convert(payload);
    if (payload != null) print('Payload :: $payloadTree');

    final multipartPayloadTree = const JsonEncoder.withIndent('  ').convert(multipartPayload);
    if (multipartPayload != null) print('Multipart Payload :: $multipartPayloadTree');

    dynamic jsonResponse;
    dynamic httpResponse;

    try {
      switch (method) {
        case (HTTPMethod.get):
          httpResponse = await http.get(url, headers: _requestCurl).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.post):
          httpResponse = await http.post(url, headers: _requestCurl, body: jsonEncode(payload)).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.put):
          httpResponse = await http.put(url, headers: _requestCurl, body: jsonEncode(payload)).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.delete):
          httpResponse = await http.delete(url, headers: _requestCurl, body: jsonEncode(payload)).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.patch):
          httpResponse = await http.patch(url, headers: _requestCurl, body: jsonEncode(payload)).timeout(Duration(seconds: _timeoutInSeconds));
          break;
        case (HTTPMethod.multipartPUT):
          httpResponse = await httpMultipart(request: http.MultipartRequest('PUT', url), payload: multipartPayload, files: multipartFiles);
          break;
        case (HTTPMethod.multipartPOST):
          httpResponse = await httpMultipart(request: http.MultipartRequest('POST', url), payload: multipartPayload, files: multipartFiles);
          break;
      }
      jsonResponse = decodeHTTPResponseBody(httpResponse: httpResponse, endpoint: endpointRawValues[endpoint]!);
    } on SocketException {
      Get.snackbar("error", "No Internet! please try again");
      throw FetchNetworkException(exceptionRawValues[Exceptions.timedOutOrNoInternet]);
    }
    return jsonResponse;
  }

  Future<dynamic> httpMultipart({required http.MultipartRequest request, Map<String, String>? payload, List<MultipartFiles>? files}) async {
    request.headers.addAll(_requestCurl);
    for (MultipartFiles file0 in (files ?? [])) {
      if (file0.file != null) {
        File file = File(file0.file!.path);
        request.files.add(http.MultipartFile(file0.key, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
      }
    }
    if (payload != null) request.fields.addAll(payload);
    http.Response response = await http.Response.fromStream(await request.send()).timeout(Duration(seconds: _timeoutInSeconds));
    return response;
  }

  dynamic decodeHTTPResponseBody({required http.Response httpResponse, required String endpoint}) {
    print('Status code for $endpoint :: ${httpResponse.statusCode}');
    switch (httpResponse.statusCode) {
      case (201):
        try {
          final responseJson = json.decode(httpResponse.body.toString());
          final responseTree = const JsonEncoder.withIndent('  ').convert(responseJson);
          print('Response for $endpoint :: $responseTree');
          return responseJson;
        } catch (_) {
          throw FetchNetworkException(exceptionRawValues[Exceptions.unPreocessableResponse]);
        }
      case (200):
        try {
          print("i am in 200");
          final responseJson = json.decode(httpResponse.body.toString());
          print("i am in 200 1");
          final responseTree = const JsonEncoder.withIndent('  ').convert(responseJson);
          print(responseTree);

          // print('Response for $endpoint :: $responseTree');
          return responseJson;
        } catch (_) {
          throw FetchNetworkException(exceptionRawValues[Exceptions.unPreocessableResponse]);
        }
      case (400):
        throw FetchNetworkException(exceptionRawValues[Exceptions.badRequest400]);
      case (401):
        throw UnauthorizedException(exceptionRawValues[Exceptions.unauthorized401]);
      case (403):
        final body = httpResponse.body;
        final decoded = jsonDecode(body);
        final message = decoded['message'] ?? 'Unauthorized access';
      // showLogoutDialog(
      //   text: message,
      //   onTap: () {
      //     Get.find<ProfileController>().logout();
      //   },
      // );
      case (404):
        final body = httpResponse.body;
        final decoded = jsonDecode(body);
        final message = decoded['message'] ?? 'Unauthorized access';
        Get.snackbar("error", message);
        throw FetchNetworkException(exceptionRawValues[Exceptions.requestNotFound404]);
      case (405):
        throw FetchNetworkException(exceptionRawValues[Exceptions.methodNotAllowd405]);
      case (409):
        throw FetchNetworkException(exceptionRawValues[Exceptions.conflictInRequest409]);
      case (500):
        try {
          final responseJson = json.decode(httpResponse.body.toString());
          final responseTree = const JsonEncoder.withIndent('  ').convert(responseJson);
          print('Response for $endpoint :: $responseTree');
          return responseJson;
        } catch (_) {
          throw FetchNetworkException(exceptionRawValues[Exceptions.serverError500]);
        }
      case (503):
        throw FetchNetworkException(exceptionRawValues[Exceptions.serviceUnavailable503]);
      default:
        throw FetchNetworkException(exceptionRawValues[Exceptions.unknownError000]);
    }
  }
}

enum HTTPMethod { get, post, put, delete, patch, multipartPUT, multipartPOST }

enum Result { onFailed, onSuccess, onException }
