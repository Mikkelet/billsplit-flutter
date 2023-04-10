import 'dart:convert';
import 'dart:io';

import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class NetworkClient {
  static String baseUrl = Platform.isAndroid
      ? "http://10.0.2.2:5000/billsplittapp/us-central1/v1/"
      : "http://localhost:5000/billsplittapp/us-central1/v1/";

  final _client = RetryClient(http.Client());
  final _authProvider = getIt<AuthProvider>();

  void onDestroy() {
    _client.close();
  }

  Future<Json> get(String path, {bool refreshToken = false}) async {
    final url = Uri.parse("$baseUrl$path");
    final token = refreshToken
        ? await _authProvider.getToken(true)
        : await _authProvider.getToken(false);
    final response = await _client.get(url, headers: {"Authorization": token});
    print("Request: ${response.request}");
    print("Request: ${response.request?.headers}");
    print('Response status: ${response.statusCode}');
    print('Response body:${response.body}');
    if (response.statusCode == 408) {
      return get(path, refreshToken: true);
    }
    return response.toJson();
  }

  Future<Json> post(String path, Json body) async {
    final response = await _client.post(Uri.http(baseUrl, path), body: body);
    return response.toJson();
  }

  Future<Json> put(String path) async {
    final response = await _client.put(Uri.http(baseUrl, path));
    return response.toJson();
  }
}

extension CallExt on http.Response {
  Json toJson() {
    return jsonDecode(utf8.decode(bodyBytes)) as Json;
  }
}
