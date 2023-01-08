import 'dart:convert';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request({
    required String? url,
    required String? method,
    Map<dynamic, dynamic>? body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(Uri.parse(url ?? ''),
        headers: headers, body: jsonBody);

    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      default:
        return null;
    }
  }
}
