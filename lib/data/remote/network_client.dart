import 'dart:convert';
import 'dart:io';

import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/remote/errors/billsplit_error.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';

class NetworkClient {
  static bool allowNetworkLogging = false;
  static bool debug = true;
  static String debugBaseUrl = Platform.isAndroid
      ? "http://10.0.2.2:5000/billsplittapp/us-central1/v2/"
      : "http://localhost:5000/billsplittapp/us-central1/v2/";
  static String devUrl = "http://192.168.8.227:5000/billsplittapp/us-central1/v2/";
  static String releaseBaseUrl =
      "https://us-central1-billsplittapp.cloudfunctions.net/v2/";
  static String baseUrl = debug ? debugBaseUrl : releaseBaseUrl;

  final _client = RetryClient(http.Client());
  final _authProvider = getIt<AuthProvider>();

  void onDestroy() {
    _client.close();
  }

  Future<Json> get(String path, {bool refreshToken = false}) async {
    if(allowNetworkLogging) {
      print("qqq baseUrl=$baseUrl$path");
    }
    final url = Uri.parse("$baseUrl$path");
    final token = refreshToken
        ? await _authProvider.getToken(true)
        : await _authProvider.getToken(false);
    final headers = {
      HttpHeaders.authorizationHeader: token,
    };
    final response = await _client.get(url, headers: headers);
    if(allowNetworkLogging) {
      print("Request: ${response.request}");
      print("Request: ${response.request?.headers}");
      print('Response status: ${response.statusCode}');
      print('Response body:${response.body}');
    }
    if (response.statusCode == 408) {
      return get(path, refreshToken: true);
    }
    if (!response.statusCode.toString().startsWith("2")) {
      throw UiException(response.statusCode, response.body.toString());
    }
    return response.toJson();
  }

  Future<Json> post(String path, Json body, {bool refreshToken = false}) async {
    final url = Uri.parse("$baseUrl$path");
    final token = refreshToken
        ? await _authProvider.getToken(true)
        : await _authProvider.getToken(false);
    final headers = {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.contentTypeHeader: "application/json"
    };

    final response =
        await _client.post(url, body: json.encode(body), headers: headers);
    if(allowNetworkLogging) {
      print('Request body:$body');
      print("Request headers: $headers");
      print("Request: ${response.request}");
      print("Response headers: ${response.request?.headers}");
      print('Response status: ${response.statusCode}');
      print('Response body:${response.body}');
    }
    if (response.statusCode == 408) {
      return get(path, refreshToken: true);
    }
    if (!response.statusCode.toString().startsWith("2")) {
      final error = BillSplitError.fromJson(response.toJson());
      throw UiException(error.code, error.message);
    }
    return response.toJson();
  }

  Future<Json?> put(String path, Json body, {bool refreshToken = false}) async {
    final url = Uri.parse("$baseUrl$path");
    final token = refreshToken
        ? await _authProvider.getToken(true)
        : await _authProvider.getToken(false);
    final headers = {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.contentTypeHeader: "application/json"
    };
    final response =
        await _client.put(url, body: json.encode(body), headers: headers);
    if(allowNetworkLogging) {
      print('Request body:$body');
      print("Request headers: $headers");

      print("Request: ${response.request}");
      print("Response headers: ${response.request?.headers}");
      print('Response status: ${response.statusCode}');
      print('Response body:${response.body}');
    }
    if (response.statusCode == 408) {
      return get(path, refreshToken: true);
    }
    if (response.statusCode == 204) {
      return null;
    }
    if (!response.statusCode.toString().startsWith("2")) {
      final error = BillSplitError.fromJson(response.toJson());
      throw UiException(error.code, error.message);
    }
    return response.toJson();
  }

  Future<Json?> delete(String path,
      {Json? body, bool refreshToken = false}) async {
    final url = Uri.parse("$baseUrl$path");
    final token = refreshToken
        ? await _authProvider.getToken(true)
        : await _authProvider.getToken(false);
    final headers = {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.contentTypeHeader: "application/json"
    };

    Response response;
    if (body == null) {
      response = await _client.delete(url, headers: headers);
    } else {
      response =
          await _client.delete(url, body: json.encode(body), headers: headers);
    }
    if(allowNetworkLogging) {
      print('Request body:$body');
      print("Request headers: $headers");
      print("Request body: ${response.body}");
      print("Response headers: ${response.request?.headers}");
      print('Response status: ${response.statusCode}');
    }
    if (response.statusCode == 408) {
      return get(path, refreshToken: true);
    }
    if (response.statusCode == 204) {
      return null;
    }
    if (!response.statusCode.toString().startsWith("2")) {
      final error = BillSplitError.fromJson(response.toJson());
      throw UiException(error.code, error.message);
    }
    return response.toJson();
  }
}

extension CallExt on http.Response {
  Json toJson() {
    return jsonDecode(utf8.decode(bodyBytes)) as Json;
  }
}
