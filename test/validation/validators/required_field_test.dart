import 'package:test/test.dart';

abstract class FieldValidation {
  String? validate(String value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;
  RequiredFieldValidation(this.field);

  String? validate(String value) {}
}

void main() {
  test('Should return null if vaue is not empty', () {
    final sut = RequiredFieldValidation('any_field');

    final error = sut.validate('any_value');

    expect(error, null);
  });
}
