import 'dart:async';
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

  Stream<String> stream(
    Uri uri, {
    required Map<String, String> headers,
    required Object body,
  }) async* {
    final request = http.Request('POST', uri);
    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    final response = await _client.send(request);

    final stream = response.stream.transform(utf8.decoder);

    await for (final chunk in stream) {
      yield chunk;
    }
  }
}
