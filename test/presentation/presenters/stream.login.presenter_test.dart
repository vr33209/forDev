import 'dart:async';

import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class LoginState {
  String emailError = '';
  // LoginState(this.emailError);
}

class StreamLoginPresenter {
  final ValidationSpy validation;
  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({required this.validation});

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

abstract class Validation {
  String validate({required String field, required String value});
}

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
