import 'package:faker/faker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:fordev/domain/usecases/usecases.dart';
import 'package:fordev/domain/helpers/helpers.dart';

import 'package:fordev/data/usecases/remote_authentication.dart';
import 'package:fordev/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;
  late AuthenticationParams params;

  Map<dynamic, dynamic> mockValideData() =>
      {'accessToken': faker.guid.guid(), 'name': faker.person.name()};

  PostExpectation mockRequest() => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ));

  void mockHttpData(Map<dynamic, dynamic> data) =>
      mockRequest().thenAnswer((_) async => data);

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut =
        RemoteAuthentication(httpClient: httpClient, url: url, method: 'post');
    params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
    mockHttpData(mockValideData());
  });
  test('Should call HttpClient with correct values', () async {
    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient return 401',
      () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final valideData = mockValideData();

    mockHttpData(valideData);

    final account = await sut.auth(params);

    expect(account.token, valideData['accessToken']);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 500 with invalid data',
      () async {
    mockHttpData({});

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}
