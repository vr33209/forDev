import '../models/remote_account_model.dart';

import '../../domain/entities/account_entity.dart';

import '../http/http.dart';

import '../../domain/helpers/domain_error.dart';
import 'package:fordev/domain/usecases/usecases.dart';

class RemoteAuthentication implements Authentication {
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

  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse =
          await httpClient.request(url: url, method: method, body: body);

      final account = RemoteAccountModel.fromJson(httpResponse).toEntity();

      return account;
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
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
