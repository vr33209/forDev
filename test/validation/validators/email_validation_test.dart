import 'package:faker/faker.dart';
import 'package:fordev/validation/protocols/field_validation.dart';
import 'package:fordev/validation/validators/validators.dart';
import 'package:test/test.dart';

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
