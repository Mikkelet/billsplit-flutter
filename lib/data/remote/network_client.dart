import 'dart:convert';

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
    final response = await _client.get(url, headers: {
      "Authorization":
          "eyJhbGciOiJSUzI1NiIsImtpZCI6ImM4MjNkMWE0MTg5ZjI3NThjYWI4NDQ4ZmQ0MTIwN2ViZGZhMjVlMzkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTWlra2VsIFRoeWdlc2VuIiwicGljdHVyZSI6Imh0dHBzOi8vZmlyZWJhc2VzdG9yYWdlLmdvb2dsZWFwaXMuY29tL3YwL2IvYmlsbHNwbGl0dGFwcC5hcHBzcG90LmNvbS9vL0ZORTZMMzdXelFUMFhOZ1BwWGswZWkzb1FEaTIlMkZpbWFnZSUzQTEwMDAwMDIzMzA_YWx0PW1lZGlhJnRva2VuPTc2Y2E2MWY5LTE1NGItNGI0OC1hNDhkLWZlMWIzMmVmMDBkMyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9iaWxsc3BsaXR0YXBwIiwiYXVkIjoiYmlsbHNwbGl0dGFwcCIsImF1dGhfdGltZSI6MTY4MDg3Mzk2MiwidXNlcl9pZCI6IkZORTZMMzdXelFUMFhOZ1BwWGswZWkzb1FEaTIiLCJzdWIiOiJGTkU2TDM3V3pRVDBYTmdQcFhrMGVpM29RRGkyIiwiaWF0IjoxNjgwODczOTYyLCJleHAiOjE2ODA4Nzc1NjIsImVtYWlsIjoibWlra2VsZXRAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWlra2VsZXRAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.nIZbzwqJA4-NdX0pnOe7jXYqEk9h4j9tefgQficHbyHUDN3n8NRKzZFHmVh3xa_AAj03MKRfkCEjBjrKMQOkDtOHhHzZE5hNgZyjk3DzcMzJMG4xEcga85kPBsQ8Ap-E8D73eIr-K5Fe8KrshrFgV3TFlxHSAq-icm0uDmmXfaQYEHHk6ZHzAuOrfBHGipKvZQXMmNXPA-Ga2_8-mgz4ym4-wx6kIY0VqQuNJmfB_XzH1a_ytvAbmwx8WvUnoqFZBCUDRKVScsTobwIX6qKssQhKhL6VEg11itC5qYi5I9WMtH1TJgN_qSHfmvyPk4y5gjoLeqmDKC4kpbh0T6QzBg"
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

