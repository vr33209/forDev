import 'package:faker/faker.dart';
import 'package:fordev/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String email;

  EmailValidation(this.email);

  @override
  String? validate(String? value) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    final isValid =
        value?.isNotEmpty != true || emailRegex.hasMatch(value ?? '');

    return isValid ? null : 'Campo inválido.';
  }
}

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate(faker.internet.email()), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('invalid_email'), 'Campo inválido.');
  });
}
