import 'dart:convert';

import 'package:fordev/data/http/http.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

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

class ClientSpy extends Mock implements Client {}

void main() {
  late String url;

  late ClientSpy client;
  late HttpAdapter sut;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();

    registerFallbackValue(Uri.parse(url));
  });

  group('POST', () {
    When mockRequest() => when(() => client.post(any(),
        headers: any(named: 'headers'), body: any(named: 'body')));

    void mockResponse(int statusCode,
        {String body = '{"any_key": "any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      final Map<String, String> body = {'any_key': 'any_value'};

      await sut.request(url: url, method: 'post', body: body);

      verifyNever(() => client.post(
            Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'Accept': 'application/json'
            },
            body: body.toString(),
          ));
    });

    test('Should call post without body', () async {
      await sut.request(
        url: url,
        method: 'post',
      );

      verify(() => client.post(
            Uri.parse(url),
            headers: any(named: 'headers'),
          ));
    });

    test('Should return data if post return 200', () async {
      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, {"any_key": "any_value"});
    });

    test('Should return null if post return 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, null);
    });

    test('Should return data if post return 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, null);
    });

    test('Should return null if post return 204 with no data', () async {
      mockResponse(204, body: '{"any_key": "any_value"}');

      final response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(response, null);
    });
  });
}
