import 'dart:convert';

import 'package:billsplit_flutter/extensions.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  static const String baseUrl =
      "http://10.0.2.2:5000/billsplittapp/us-central1/v1/";
  final _client = http.Client();

  void onDestroy() {
    _client.close();
  }

  Future<Json> get(String path) async {
    final url = Uri.parse("$baseUrl$path");
    final response = await _client.get(url, headers: {
      "Authorization":
          "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg3YzFlN2Y4MDAzNGJiYzgxYjhmMmRiODM3OTIxZjRiZDI4N2YxZGYiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiTWlra2VsIFRoeWdlc2VuIiwicGljdHVyZSI6Imh0dHBzOi8vZmlyZWJhc2VzdG9yYWdlLmdvb2dsZWFwaXMuY29tL3YwL2IvYmlsbHNwbGl0dGFwcC5hcHBzcG90LmNvbS9vL0ZORTZMMzdXelFUMFhOZ1BwWGswZWkzb1FEaTIlMkZpbWFnZSUzQTEwMDAwMDIzMzA_YWx0PW1lZGlhJnRva2VuPTc2Y2E2MWY5LTE1NGItNGI0OC1hNDhkLWZlMWIzMmVmMDBkMyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9iaWxsc3BsaXR0YXBwIiwiYXVkIjoiYmlsbHNwbGl0dGFwcCIsImF1dGhfdGltZSI6MTY3OTgxMDU3NSwidXNlcl9pZCI6IkZORTZMMzdXelFUMFhOZ1BwWGswZWkzb1FEaTIiLCJzdWIiOiJGTkU2TDM3V3pRVDBYTmdQcFhrMGVpM29RRGkyIiwiaWF0IjoxNjgwODEzMDA3LCJleHAiOjE2ODA4MTY2MDcsImVtYWlsIjoibWlra2VsZXRAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsibWlra2VsZXRAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.Ya2Mzbgz2OYTKuOkLPBMvnuKJxFyhsqeXSHWmrKFfU5c7isOAUCbmgC2H9YozKfXWyQxoixGndQzcDedETqqhb-96K_-beowR2HmAp7G1UAr0UFl9huirM6NGzL03Vv9zDrM9yBJ0o_55t__DZk9j5KP4vlKAS6yoWaBufYCwfrA2Gni6yjV8HskXdLEwmEwUuxJG5RKQ4YCBxmK57egP9n-93i3LUn9tOu5PXSs36dfB1jNYjp9pGSCJcjfiu5K2sQG0JqAHwYGZuW_kjRgAzwRJFmrG18QpdceWU2TsOd3C4gY2W5ppKrxyRiumodhQoUdmqnbnGsufOPGubwh4w"
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

