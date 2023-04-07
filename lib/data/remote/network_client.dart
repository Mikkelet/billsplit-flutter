import 'dart:convert';

import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class NetworkClient {
  static const String baseUrl =
      "http://10.0.2.2:5000/billsplittapp/us-central1/v1/";
  final _client = RetryClient(http.Client());

  void onDestroy() {
    _client.close();
  }

  Future<Json> get(String path) async {
    final url = Uri.parse("$baseUrl$path");
    final token = await AuthProvider.instance.getToken();
    final response = await _client.get(url, headers: {
      "Authorization": token
    });
    print("Request: ${response.request}");
    print("Request: ${response.request?.headers}");
    print('Response status: ${response.statusCode}');
    print('Response body:${response.body}');
    return response.toJson();
  }

  Future<Json> post(String path) async {
    final response = await _client.post(Uri.http(baseUrl, path));
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

