import 'package:test/test.dart';

import 'package:fordev/validation/validators/required_fied.dart';

void main() {
  late RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });
  test('Should return null if value is not empty', () {
    final error = sut.validate('any_value');

    expect(error, null);
  });

  test('Should return error if value is not empty', () {
    final error = sut.validate('');

    expect(error, 'Campo obrigatório.');
  });

  test('Should return error if value is empty', () {
    final error = sut.validate('');

    expect(error, 'Campo obrigatório.');
  });
}
