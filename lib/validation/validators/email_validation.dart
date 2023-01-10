import 'package:fordev/validation/protocols/field_validation.dart';

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
