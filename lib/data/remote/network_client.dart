import 'dart:convert';
import 'dart:io';

import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/remote/errors/billsplit_error.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:json_pretty/json_pretty.dart';

class NetworkClient {
  static bool allowNetworkLogging = false;
  static bool debug = false;
  static bool emulator = false;
  static String debugBaseUrl = Platform.isAndroid
      ? "http://10.0.2.2:5000/billsplittapp/us-central1/v3/"
      : "http://localhost:5000/billsplittapp/us-central1/v3/";
  static String devUrl =
      "http://192.168.8.227:5000/billsplittapp/us-central1/v3/";
  static String releaseBaseUrl =
      "https://us-central1-billsplittapp.cloudfunctions.net/v3/";
  static String baseUrl = debug
      ? emulator
          ? debugBaseUrl
          : devUrl
      : releaseBaseUrl;

  final _client = RetryClient(http.Client());
  final _authProvider = getIt<AuthProvider>();

  void onDestroy() {
    _client.close();
  }

  Future<Json> get(String path, {bool refreshToken = false}) async {
    if (allowNetworkLogging) {
      debugPrint("qqq baseUrl=$baseUrl$path");
    }
    final url = Uri.parse("$baseUrl$path");
    final token = refreshToken
        ? await _authProvider.getToken(true)
        : await _authProvider.getToken(false);
    final headers = {
      HttpHeaders.authorizationHeader: token,
    };
    final response = await _client.get(url, headers: headers);
    if (allowNetworkLogging) {
      debugPrint("Request: ${response.request}");
      debugPrint("Request: ${response.request?.headers}", wrapWidth: 1024);
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body:${prettyPrintJson(response.body)}');
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
      HttpHeaders.authorizationHeader: "$token",
      HttpHeaders.contentTypeHeader: "application/json"
    };

    final response =
        await _client.post(url, body: json.encode(body), headers: headers);
    if (allowNetworkLogging) {
      debugPrint('Request body:$body');
      debugPrint("Request headers: $headers");
      debugPrint("Request: ${response.request}");
      debugPrint("Response headers: ${response.request?.headers}");
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body:${prettyPrintJson(response.body)}');
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
      HttpHeaders.authorizationHeader: "$token",
      HttpHeaders.contentTypeHeader: "application/json"
    };
    final response =
        await _client.put(url, body: json.encode(body), headers: headers);
    if (allowNetworkLogging) {
      debugPrint('Request body:$body');
      debugPrint("Request headers: $headers");

      debugPrint("Request: ${response.request}");
      debugPrint("Response headers: ${response.request?.headers}");
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body:${prettyPrintJson(response.body)}');

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
    if (allowNetworkLogging) {
      debugPrint('Request body:$body');
      debugPrint("Request headers: $headers");
      debugPrint("Request body: ${response.body}");
      debugPrint("Response headers: ${response.request?.headers}");
      debugPrint('Response body:${prettyPrintJson(response.body)}');
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
