import 'package:fordev/data/http/http.dart';

import 'package:fordev/domain/usecases/usecases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  final String method;
  final Map<dynamic, dynamic>? body;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
    required this.method,
    this.body,
  });

  Future<void> auth(AuthenticationParams params) async {
    final body = params.toJson();
    await httpClient.request(url: url, method: method, body: body);
  }
}
