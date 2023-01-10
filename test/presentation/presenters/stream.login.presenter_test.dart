import 'package:faker/faker.dart';
import 'package:fordev/presentation/presenter/stream_login_presenter.dart';
import 'package:fordev/presentation/protocols/protocols.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late String email;

  When mockValidationCall(String field) => when(() => validation.validate(
      field: field.isEmpty ? any(named: 'field') : field,
      value: any(named: 'value')));

  void mockValidation({required String field, required dynamic responseMock}) {
    mockValidationCall(field).thenReturn(responseMock);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation(field: '', responseMock: '');
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(field: '', responseMock: 'error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
