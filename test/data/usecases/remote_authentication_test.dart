import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordev/domain/usecases/authentication.dart';

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
    final body = {'email': params.email, 'password': params.secret};
    await httpClient.request(url: url, method: method, body: body);
  }
}

abstract class HttpClient {
  Future<void>? request({
    required String url,
    required String method,
    Map<dynamic, dynamic>? body,
  }) async {}
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut =
        RemoteAuthentication(httpClient: httpClient, url: url, method: 'post');
  });
  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());

    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });
}
