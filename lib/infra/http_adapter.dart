import 'dart:convert';

import 'package:fordev/domain/helpers/domain_error.dart';
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

    return _handleResponse(response);
  }

  Map? _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
