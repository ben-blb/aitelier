import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  final http.Client _client;

  HttpClient(this._client);

  Future<http.Response> post(
    Uri uri, {
    required Map<String, String> headers,
    required Object body,
  }) {
    return _client.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
  }
}
