import 'package:fordev/data/http/http.dart';
import 'package:fordev/domain/entities/entities.dart';

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
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    await httpClient.request(url: url, method: method, body: body);
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': email, 'password': password};
}
