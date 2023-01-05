import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  final String method;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
    required this.method,
  });

  Future<void>? auth() async {
    await httpClient.request(url: url, method: method);
  }
}

abstract class HttpClient {
  Future<void>? request({required String url, required String method}) async {}
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  test('Should call HttpClient with correct values', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut =
        RemoteAuthentication(httpClient: httpClient, url: url, method: 'post');

    await sut.auth();

    verify(httpClient.request(url: url, method: 'post'));
  });
}
